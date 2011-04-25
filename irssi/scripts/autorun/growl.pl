#!/usr/bin/env perl -w

# growl.pl
# Copyright (c) 2011 Sorin Ionescu <sorin.ionescu@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.


use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
use Growl::GNTP;
use IO::Socket::PortState qw(check_ports);

$VERSION = '1.0.7';
%IRSSI = (
    authors     => 'Sorin Ionescu',
    contact     => 'sorin.ionescu@gmail.com',
    name        => 'Growl',
    description => 'Sends Growl notifications from Irssi',
    license     => 'GPLv3',
    url         => 'http://github.com/sorin-ionescu/irssi-growl',
);

# Notification Settings
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_message_public', 0);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_message_private', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_message_action', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_message_notice', 0);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_message_invite', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_highlight', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_notifylist', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_server', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_channel_topic', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_show_dcc', 1);

# Network Settings
Irssi::settings_add_str($IRSSI{'name'}, 'growl_net_host', 'localhost');
Irssi::settings_add_str($IRSSI{'name'}, 'growl_net_port', '23053');
Irssi::settings_add_str($IRSSI{'name'}, 'growl_net_pass', '');

# Icon Settings
Irssi::settings_add_str($IRSSI{'name'}, 'growl_net_icon', 'icon.png');

# Sticky Settings
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_net_sticky', 0);
Irssi::settings_add_bool($IRSSI{'name'}, 'growl_net_sticky_away', 1);

# Growl Initialization
my $growl = Growl::GNTP->new(
    AppName  => "Irssi",
    PeerHost => Irssi::settings_get_str('growl_net_host'),
    PeerPort => Irssi::settings_get_str('growl_net_port'),
    AppIcon  => Irssi::settings_get_str('growl_net_icon'),
    Password => Irssi::settings_get_str('growl_net_pass'),
);

# Growl Registration
eval {
    $growl->register([
        { Name => "Public", },
        { Name => "Private", },
        { Name => "Action", },
        { Name => "Notice", },
        { Name => "Invite", },
        { Name => "Highlight", },
        { Name => "Notify List", },
        { Name => "Server", },
        { Name => "Channel", },
        { Name => "DCC", },
    ]);
} or do {
    if ($@) {
        Irssi::print("growl: Could not register, connection refused.");
    }
};

sub cmd_help {
    Irssi::print('Growl can be configured with these settings:');
    Irssi::print('%WNotification Settings%n');
    Irssi::print('  %ygrowl_show_message_public%n : Notify on public message. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_message_private%n : Notify on private message. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_message_action%n : Notify on action message. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_message_notice%n : Notify on notice message. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_message_invite%n : Notify on channel invitation message. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_highlight%n : Notify on nick highlight. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_notifylist%n : Notify on notification list connect and disconnect. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_server%n : Notify on server connect and disconnect. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_channel_topic%n : Notify on channel topic change. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_show_dcc_request%n : Notify on DCC chat/file transfer messeges. (ON/OFF/TOGGLE)');

    Irssi::print('%WNetwork Settings%n');
    Irssi::print('  %ygrowl_net_host%n : Set the Growl server host.');
    Irssi::print('  %ygrowl_net_port%n : Set the Growl server port.');
    Irssi::print('  %ygrowl_net_pass%n : Set the Growl server password.');

    Irssi::print('%WIcon Settings%n');
    Irssi::print('  %ygrowl_net_icon%n : Set the Growl notification icon path.');

    Irssi::print('%WSticky Settings%n');
    Irssi::print('  %ygrowl_net_sticky%n : Set sticky notifications. (ON/OFF/TOGGLE)');
    Irssi::print('  %ygrowl_net_sticky_away%n : Set sticky notifications only when away. (ON/OFF/TOGGLE)');
}

sub is_growl_connectable {
    my $host = Irssi::settings_get_str('growl_net_host');
    my $port = Irssi::settings_get_str('growl_net_port');
    my $timeout = 5;
    my %port_hash = (
        tcp => {
            $port => {
                name => 'Growl',
            },
        },
    );

    check_ports($host, $timeout, \%port_hash);
    return $port_hash{tcp}{$port}{open};
}

sub is_notification_sticky {
    my ($server);
    $server = Irssi::active_server();
    if (Irssi::settings_get_bool('growl_net_sticky_away')) {
        if (!$server->{usermode_away}) {
            return 0;
        } else {
            return 1;
        }
    } else {
        return Irssi::settings_get_bool('growl_net_sticky');
    }
}

sub growl_notify {
    my $icon = "file://$ENV{'HOME'}/.irssi/" . Irssi::settings_get_str('growl_net_icon');
    my $sticky = is_notification_sticky();
    my ($event, $title, $message, $priority) = @_;

    if (!is_growl_connectable()) {
        Irssi::print('growl: Could not notify, connection refused.');
        return;
    }

    eval {
        $growl->notify(
            Event    => $event,
            Title    => $title,
            Message  => $message,
            Icon     => $icon,
            Priotity => $priority,
            Sticky   => $sticky
        );
    } or do {
        if ($@) {
            Irssi::print('growl: Could not notify, connection refused.');
        }
    };
}

sub sig_message_public {
    return unless Irssi::settings_get_bool('growl_show_message_public');
    my ($server, $msg, $nick, $address, $target) = @_;
    growl_notify("Public", "Public Message", "$nick: $msg", 0);
}

sub sig_message_private {
    return unless Irssi::settings_get_bool('growl_show_message_private');
    my ($server, $msg, $nick, $address) = @_;
    growl_notify("Private", "Private Message", "$nick: $msg", 1);
}

sub sig_message_dcc {
    return unless Irssi::settings_get_bool('growl_show_message_private');
    my ($dcc, $msg) = @_;
    growl_notify("Private", "Private Message", "$dcc->{nick}: $msg", 1);
}

sub sig_ctcp_action {
    return unless Irssi::settings_get_bool('growl_show_message_action');
    my ($server, $args, $nick, $address, $target) = @_;
    growl_notify("Action", "Action Message", "$nick: $args", 1);
}

sub sig_message_dcc_action {
    return unless Irssi::settings_get_bool('growl_show_message_action');
    my ($dcc, $msg) = @_;
    growl_notify("Action", "Action Message", "$dcc->{nick}: $msg", 1);
}

sub sig_event_notice {
    return unless Irssi::settings_get_bool('growl_show_message_notice');
    my ($server, $data, $source) = @_;
    $data =~ s/^[^:]*://;
    growl_notify("Notice", "Notice Message", "$source: $data", 1);
}

sub sig_message_invite {
    return unless Irssi::settings_get_bool('growl_show_message_invite');
    my ($server, $channel, $nick, $address) = @_;
    growl_notify(
        "Invite",
        "Channel Invitation",
        "$nick has invited you to join $channel.",
        1
    );
}

sub sig_print_text {
    return unless Irssi::settings_get_bool('growl_show_highlight');
    my ($dest, $text, $stripped) = @_;
    my $nick;
    my $msg;
    if ($dest->{level} & MSGLEVEL_HILIGHT) {
        $stripped =~ s/^\s+|\s+$//g;
        growl_notify("Highlight", "Highlighted Message", $stripped, 2);
    }
}

sub sig_notifylist_joined {
    return unless Irssi::settings_get_bool('growl_show_notifylist');
    my ($server, $nick, $user, $host, $realname, $awaymsg) = @_;
    growl_notify(
        "Notify List",
        "Friend Connected",
        ("$realname" || "$nick") . " has connected to $server->{chatnet}.",
        0
    );
}

sub sig_notifylist_left {
    return unless Irssi::settings_get_bool('growl_show_notifylist');
    my ($server, $nick, $user, $host, $realname, $awaymsg) = @_;
    growl_notify(
        "Notify List",
        "Friend Disconnected",
        ("$realname" || "$nick") . " has disconnected from $server->{chatnet}.",
        0
    );
}

sub sig_server_connected {
    return unless Irssi::settings_get_bool('growl_show_server');
    my($server) = @_;
    growl_notify(
        "Server",
        "Server Connected",
        "Connected to network $server->{chatnet}.",
        0
    );
}

sub sig_server_disconnected {
    return unless Irssi::settings_get_bool('growl_show_server');
    my($server) = @_;
    growl_notify(
        "Server",
        "Server Disconnected",
        "Disconnected from network $server->{chatnet}.",
        0
    );
}

sub sig_channel_topic_changed {
    return unless Irssi::settings_get_bool('growl_show_channel_topic');
    my ($channel) = @_;
    growl_notify(
        "Channel",
        "Channel Topic",
        "$channel->{name}: $channel->{topic}",
        0
    );
}

sub sig_dcc_request {
    return unless Irssi::settings_get_bool('growl_show_dcc');
    my ($dcc, $sendaddr) = @_;
    my $title;
    my $message;
    if ($dcc->{type} =~ /CHAT/) {
        $title = "Direct Chat Request";
        $message = "$dcc->{nick} wants to chat directly.";
    }
    if ($dcc->{type} =~ /GET/) {
        $title = "File Transfer Request";
        $message = "$dcc->{nick} wants to send you $dcc->{arg}.";
    }
    growl_notify("DCC", $title, $message, 0);
}

sub sig_dcc_closed {
    return unless Irssi::settings_get_bool('growl_show_dcc');
    my ($dcc) = @_;
    my $title;
    my $message;

    if ($dcc->{type} =~ /GET|SEND/) {
        if ($dcc->{size} == $dcc->{transfd}) {
            if ($dcc->{type} =~ /GET/) {
                $title = "Download Complete";
            }
            if ($dcc->{type} =~ /SEND/) {
                $title = "Upload Complete";
            }
        }
        else {
            if ($dcc->{type} =~ /GET/) {
                $title = "Download Failed";
            }
            if ($dcc->{type} =~ /SEND/) {
                $title = "Upload Failed";
            }
        }
        $message = $dcc->{arg};
    }

    if ($dcc->{type} =~ /CHAT/) {
        $title = "Direct Chat Ended";
        $message = "Direct chat with $dcc->{nick} has ended.";
    }
    growl_notify("DCC", $title, $message, 0);
}

Irssi::command_bind('growl', 'cmd_help');

Irssi::signal_add_last('message public', \&sig_message_public);
Irssi::signal_add_last('message private', \&sig_message_private);
Irssi::signal_add_last('message dcc', \&sig_message_dcc);
Irssi::signal_add_last('ctcp action', \&sig_ctcp_action);
Irssi::signal_add_last('message dcc action', \&sig_message_dcc_action);
Irssi::signal_add_last('event notice', \&sig_event_notice);
Irssi::signal_add_last('message invite', \&sig_message_invite);
Irssi::signal_add_last('print text', \&sig_print_text);
Irssi::signal_add_last('notifylist joined', \&sig_notifylist_joined);
Irssi::signal_add_last('notifylist left', \&sig_notifylist_left);
Irssi::signal_add_last('server connected', \&sig_server_connected);
Irssi::signal_add_last('server disconnected', \&sig_server_disconnected);
Irssi::signal_add_last('channel topic changed', \&sig_channel_topic_changed);
Irssi::signal_add_last('dcc request', \&sig_dcc_request);
Irssi::signal_add_last('dcc closed', \&sig_dcc_closed);

