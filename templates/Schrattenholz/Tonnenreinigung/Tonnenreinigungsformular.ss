<!DOCTYPE html>
<!--


<!--[if !IE]><!-->
<html lang="$ContentLocale">
<!--<![endif]-->
<!--[if IE 6 ]><html lang="$ContentLocale" class="ie ie6"><![endif]-->
<!--[if IE 7 ]><html lang="$ContentLocale" class="ie ie7"><![endif]-->
<!--[if IE 8 ]><html lang="$ContentLocale" class="ie ie8"><![endif]-->
<head>
	<% base_tag %>
	<title><% if $MetaTitle %>$MetaTitle<% else %>$Title<% end_if %> &raquo; $SiteConfig.Title</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	$MetaTags(false)
<!-- CSS
    ================================================== -->
<!-- Bootstrap  -->
<link type="text/css" rel="stylesheet" href="$ThemeDir/bootstrap/css/bootstrap.min.css">
<!-- web font  -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,800" rel="stylesheet" type="text/css">
<!-- plugin css  -->
<link type="text/css" rel="stylesheet" href="$ThemeDir/js-plugin/hoverdir/css/style.css">
<link rel="stylesheet" type="text/css" href="$ThemeDir/js-plugin/rs-plugin/css/settings.css" media="screen" />
<!-- icon fonts -->
<link type="text/css" rel="stylesheet" href="$ThemeDir/font-icons/custom-icons/css/custom-icons.css">
<link type="text/css" rel="stylesheet" href="$ThemeDir/font-icons/custom-icons/css/custom-icons-ie7.css">
<!-- Custom css -->
<link type="text/css" rel="stylesheet" href="$ThemeDir/css/layout.css">
<link type="text/css" id="colors" rel="stylesheet" href="$ThemeDir/css/colors.css">
<!--[if lt IE 9]><script src="https://html5shim.googlecode.com/svn/trunk/html5.js"></script> <![endif]-->
<script src="$ThemeDir/js/modernizr-2.6.1.min.js"></script>
<!-- Favicons
    ================================================== -->
<link rel="shortcut icon" href="{$ThemeDir}/images/favicon.ico">
<link rel="apple-touch-icon" href="{$ThemeDir}/images/apple-touch-icon.png">
<link rel="apple-touch-icon" sizes="72x72" href="{$ThemeDir}/images/apple-touch-icon-72x72.png">
<link rel="apple-touch-icon" sizes="114x114" href="{$ThemeDir}/images/apple-touch-icon-114x114.png">
<link rel="apple-touch-icon" sizes="144x144" href="{$ThemeDir}/images/apple-touch-icon-144x144.png">
</head>
<body>
<!-- Primary Page Layout 
    ================================================== -->
<!-- globalWrapper -->
<div id="globalWrapper">
  <!-- header -->
  
  <% include Header %>
  <!-- header -->
  <!-- slider -->
  <% include Slider %>
  <!-- slider -->
$Layout
  <!-- content -->
  <!-- footer -->
  <% include Footer %>
  <!-- End footer -->
</div>
<!-- global wrapper -->
<!-- End Document 
    ================================================== -->
<script type="text/javascript" src="{$ThemeDir}/js-plugin/respond/respond.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript" src="{$ThemeDir}/js-plugin/jquery-ui/jquery-ui-1.8.23.custom.min.js"></script>
<script src="https://maps.google.com/maps/api/js?sensor=false"></script>
<!-- third party plugins  -->
<script type="text/javascript" src="{$ThemeDir}/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="{$ThemeDir}/bootstrap/js/bootstrap-carousel-ie.js"></script>
<script type="text/javascript" src="{$ThemeDir}/js-plugin/pretty-photo/js/jquery.prettyPhoto.js"></script>
<script type="text/javascript" src="{$ThemeDir}/js-plugin/easing/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="{$ThemeDir}/js-plugin/hoverdir/jquery.hoverdir.js"></script>
<!-- jQuery KenBurn Slider  -->
<script type="text/javascript" src="{$ThemeDir}/js-plugin/rs-plugin/js/jquery.themepunch.plugins.min.js"></script>
<script type="text/javascript" src="{$ThemeDir}/js-plugin/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
<!-- Custom  -->
<script type="text/javascript" src="{$ThemeDir}/js/custom.js"></script>
<script type="text/javascript" src="{$ThemeDir}/js/ts.js"></script>
</body>
</html>
