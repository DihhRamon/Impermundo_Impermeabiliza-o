Add-Type -AssemblyName System.Drawing
$images = @('servico_area_lazer.png', 'servico_caixa_dagua.png', 'servico_manta_asfaltica.png', 'servico_piscina.png', 'servico_piso.png')
foreach ($img in $images) {
    $path = "c:\Users\Diego\Desktop\Diego\Impermundo\assets\raw_files\$img"
    if (Test-Path $path) {
        $image = [System.Drawing.Image]::FromFile($path)
        $newWidth = [int][math]::Round($image.Width * 0.75)
        $newHeight = [int][math]::Round($image.Height * 0.75)
        if ($newWidth -gt 0 -and $newHeight -gt 0) {
            $newImage = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
            $graphics = [System.Drawing.Graphics]::FromImage($newImage)
            $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $graphics.DrawImage($image, 0, 0, $newWidth, $newHeight)
            $image.Dispose()
            $graphics.Dispose()
            $newPath = $path.Replace('.png', '_75.png')
            $newImage.Save($newPath, [System.Drawing.Imaging.ImageFormat]::Png)
            $newImage.Dispose()
            Write-Output "Resized $img to $newWidth x $newHeight"
        } else {
            $image.Dispose()
        }
    } else {
        Write-Output "Not found $img"
    }
}
