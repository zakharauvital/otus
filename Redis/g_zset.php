<?php

for ($i = 1; $i <= 200000; $i++) {
    $json = <<<"JSON"
{"colour":"blue","make":"saab","model":$i,"features":["powerlocks","moonroof"]}
JSON;
    $data = 'ZADD zset ' . $i . ' "' . addslashes($json) . '"' . PHP_EOL;
    file_put_contents('./datasets/zset.txt', $data, FILE_APPEND);
}

