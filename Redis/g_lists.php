<?php

$json = <<<'JSON'
{"colour":"blue","make":"saab","model":93,"features":["powerlocks","moonroof"]}
JSON;


for ($i = 1; $i <= 200000; $i++) {
    $data = 'RPUSH list:'. $i . ' "'. addslashes($json) . '"' . PHP_EOL;
    file_put_contents('./datasets/lists.txt', $data, FILE_APPEND);
}
