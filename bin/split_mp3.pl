#!/usr/bin/perl -w

use strict;

my $input = 'Bloodborne & The Old Hunters DLC Soundtrack - Full Album (OST No SFX).mp3';

my @tracks = (
 ['0:00', '2:06', 'Omen', 1],
 ['2:07', '4:12', 'The Night Unfurls', 1],
 ['4:13', '7:47', 'Hunter\'s Dream', 1],
 ['7:48', '11:10', 'The Hunter', 1],
 ['11:11', '14:17', 'Cleric Beast', 1],
 ['14:18', '18:59', 'Blood-Starved Beast', 1],
 ['19:00', '22:50', 'Terror', 1],
 ['22:51', '26:02', 'Watchers', 1],
 ['26:03', '28:58', 'Hail the Nightmare', 1],
 ['28:59', '33:54', 'Darkbeast', 1],
 ['33:55', '37:36', 'The Witch of Hemwick', 1],
 ['37:37', '41:05', 'Amygdala', 1],
 ['41:06', '44:38', 'Rom, the Vacuous Spider', 1],

 # CD 2:
 ['44:39', '48:07', 'Moonlit Melody', 2],
 ['48:08', '51:41', 'The One Reborn ', 2],
 ['51:42', '55:24', 'Micolash, Nightmare Host', 2],
 ['55:25', '59:08', 'Of the Pthumerian Line', 2],
 ['59:09', '1:03:01', 'Queen of the Vilebloods', 2],
 ['1:03:02', '1:05:05', 'Soothing Hymn', 2],
 ['1:05:06', '1:08:01', 'Celestial Emissary', 2],
 ['1:08:02', '1:11:59', 'Ebrietas, Daughter of the Cosmos', 2],
 ['1:12:00', '1:15:48', 'Lullaby for Mergo', 2],
 ['1:15:49', '1:21:00', 'The First Hunter', 2],
 ['1:21:01', '1:23:45', 'Moon Presence', 2],
 ['1:23:46', '1:26:23', 'Bloodborne', 2],

 # The Old Hunter Mini Soundtrack Tracklist:
 ['1:26:24', '1:30:31', 'Ludwig, the Holy Blade', 3],
 ['1:30:32', '1:35:28', 'Laurence, the First Vicar', 3],
 ['1:35:29', '1:39:23', 'Living Failures', 3],
 ['1:39:24', '1:44:09', 'Lady Maria of the Astral Clocktower', 3],
 ['1:44:10', '1:48:31', 'Orphan of Kos', 3],
);

my $track_number = 0;

foreach my $track (@tracks) {
    $track_number++;

    my $track_name = $track->[2];
    $track_name =~ s/[^\w]+/_/g;
    $track_name =~ s/[^\w]+/_/g;

    my @cmd = ('ffmpeg',
        '-i', $input,
        '-ss', $track->[0],
        '-to', $track->[1],
        '-c', 'copy',
        '-metadata', 'album=Bloodborne & The Old Hunters DLC Soundtrack',
        '-metadata', 'title=' . $track->[2],
        '-metadata', 'track=' . $track_number,
        '-metadata', 'desc=' . $track->[3],
        '-metadata', 'composer=Ryan Amon, Tsukasa Saitoh, Michael Wandmacher, Yuka Kitamura, Cris Velasco & Nobuyoshi Suzuki',
        "${track_number}_${track_name}.mp3");

    warn join(' ', @cmd);

    (0 == system @cmd) || die "ffmpeg failed: $!";
}
