<?php

for ($i = 1; $i <= 200000; $i++) {
    $data = 'HSET hset:'. $i . ' "colour" "blue" "make" "saab" "model" 93 "features" "powerlocks,moonroof" ' . PHP_EOL;
    file_put_contents('./datasets/hset.txt', $data, FILE_APPEND);
}
