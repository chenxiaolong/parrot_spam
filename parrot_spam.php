#!/usr/bin/env php
<?php

$avail = 4000;
$total = 0;

$items = array_slice($argv, 1);

foreach ($items as $item) {
    $total += strlen($item);
}

if ($total === 0) {
    fwrite(STDERR, "Nothing to repeat\n");
    exit(1);
}

while (true) {
    foreach ($items as $item) {
        if ($avail < strlen($item)) {
            break 2;
        }
        fwrite(STDOUT, $item);
        $avail -= strlen($item);
    }
}

?>
