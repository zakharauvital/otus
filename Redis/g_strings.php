<?php

$json = <<<'JSON'
{"colour":"blue","make":"saab","model":93,"features":["powerlocks","moonroof"]}
JSON;


for ($i = 1; $i <= 200000; $i++) {
    $data = 'SET string:'. $i . ' "'. addslashes($json) . '"' . PHP_EOL;
    file_put_contents('./datasets/string.txt', $data, FILE_APPEND);
}
