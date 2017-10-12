<?php

// Configure ClamAV plugin
$defaults['clamav']['runningmethod'] = 'commandline';
$defaults['clamav']['pathtoclam'] = '/usr/bin/clamdscan';
$defaults['clamav']['clamfailureonupload'] = 'actlikevirus';
// Enable ClamAV plugin
$defaults['moodle']['antiviruses'] = 'clamav';
