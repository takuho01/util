# Load necessary .NET assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Desired fixed width (you can change this value)
$desiredWidth = 500  # For example: 200 pixels

# Check if the clipboard contains an image
if ([System.Windows.Forms.Clipboard]::ContainsImage()) {
    $originalImage = [System.Windows.Forms.Clipboard]::GetImage()
    $aspectRatio = $originalImage.Height / $originalImage.Width
    $newHeight = [Math]::Round($desiredWidth * $aspectRatio)

    # Check the new dimensions are valid
    if ($desiredWidth -gt 0 -and $newHeight -gt 0) {
        $resizedBitmap = New-Object System.Drawing.Bitmap($originalImage, $desiredWidth, $newHeight)
        $graphics = [System.Drawing.Graphics]::FromImage($resizedBitmap)
        $graphics.DrawImage($originalImage, 0, 0, $desiredWidth, $newHeight)

        # Set the resized image back to the clipboard
        [System.Windows.Forms.Clipboard]::SetImage($resizedBitmap)

        Write-Host "Image has been resized and set back to the clipboard."

        # Cleanup resources
        $graphics.Dispose()
        $originalImage.Dispose()
        $resizedBitmap.Dispose()
    } else {
        Write-Host "Invalid dimensions for resized image: Width $desiredWidth, Height $newHeight"
    }
} 
# Check if the clipboard contains text
elseif (-not [string]::IsNullOrEmpty([System.Windows.Forms.Clipboard]::GetText())) {
    $clipboardText = [System.Windows.Forms.Clipboard]::GetText()
    Write-Host "Text from Clipboard: $clipboardText"
} 
else {
    Write-Host "Clipboard is empty or the content type is not recognized."
}
