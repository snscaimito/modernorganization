---
layout: main
title: Coaches for the Modern Organization
---


<table>
	<tr>
		<td rowspan="4"><img id="personImage" src=""/></td>
		<td><span id="personName"/></td>
	</tr>
	<tr>
		<td><span id="personPhone"/></td>
	</tr>
	<tr>
		<td><a id="personMailUrl"><span id="personMail"/></a></td>
	</tr>
	<tr>
		<td><a id="personUrl"><span id="personUrlTitle"/></a></td>
	</tr>
	<tr>
		<td colspan="2"><span id="personAbout"/></td>
	</tr>
	<tr>
		<td colspan="2"><span id="personLocation"/></td>
	</tr>
</table>


<script type="text/javascript">
function fillProfile( profile ) {
    $('#personName').text(profile.entry[0].displayName);
	$('#personImage').attr('src', profile.entry[0].thumbnailUrl) ;
    $('#personPhone').text(profile.entry[0].phoneNumbers[0].value);
    $('#personAbout').html(profile.entry[0].aboutMe);
    $('#personLocation').html(profile.entry[0].currentLocation);

    $('#personMail').text(profile.entry[0].emails[0].value);
    $('#personMailUrl').attr('href', 'mailto:' + profile.entry[0].emails[0].value);

	
    $('#personUrlTitle').text(profile.entry[0].urls[0].title);
    $('#personUrl').attr('href', profile.entry[0].urls[0].value);
}
</script>
 
<script src="https://www.gravatar.com/663d11426b0a187ddac59f8c17ce61b4.json?callback=fillProfile" type="text/javascript"></script>
