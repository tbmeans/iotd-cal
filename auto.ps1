$res = Invoke-WebRequest "https://bing.com"
$iSplit = $res.Content -split '<div class="musCardCont">'
$mscard = ($iSplit[1] -split '<div class="headline">')[0]
$iquery = (($mscard -split 'search\?q=')[1] -split '&amp;')[0]
$imdate =  (($mscard -split '&quot;')[1] -split '_')[0] + '01'
$titled = ((($mscard -split 'Image of the day: ')[1] -split '>')[1] -split '<')[0]
$copyrt = (($mscard -split 'id="copyright">')[1] -split '<')[0]
$WALLPAPER_IS_PERMITTED = 'Download this image. Use of this image is restricted to wallpaper only.'
$IMAGE_IS_NOT_AVAILABLE = 'This image is not available to download as wallpaper.'
$permis = ((($mscard -split '<ul class="share"><li>')[1] -split 'title="')[1] -split '"')[0]
if (  $permis == $WALLPAPER_IS_PERMITTED )
{
	$srckey = ($mscard -split 'th\?id=OHR.')[1] -split '_'
	$source = $srckey[0] + '_' + $srckey[1]
} elseif ( $permis == $IMAGE_IS_NOT_AVAILABLE )
{
	$source = ((($iSplit[0] -split '<div class="hp_media_container">')[1] -split 'th\?id=OHR.')[1] -split '&quot;')[0]
}
$titled + "`n" + $copyrt + "`n" + $source
