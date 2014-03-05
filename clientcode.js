var API_URL_PREFIX = "/healthylinkx/api.php?rquest=";

function showSearchResults() {

	$('#MessageArea').hide();

	var requeststring = API_URL_PREFIX+"providers";

	var buffer= $('#zipCode').val();
	if (buffer){
		requeststring+="&zipcode=";
		requeststring+=buffer;
	}
	
	buffer="";
	var buffer= $('#gender').val();
	if ((buffer[0]=='M')||(buffer[0]=='F')){
		requeststring+="&gender=";
		requeststring+=buffer[0];
	}

	buffer="";
	var buffer= $('#lastname').val();
	if (buffer){
		requeststring+="&lastname1=";
		requeststring+=buffer;
	}

	buffer="";
	var buffer= $('#specialty').val();
	if (buffer){
		requeststring+="&specialty=";
		requeststring+=buffer;
	}

	buffer="";
	var buffer= $('#distance').val();
	if (buffer){
		requeststring+="&distance=";
		requeststring+=buffer;
	}

	$.getJSON(requeststring,function(data){
		$('#resultsTable tbody').empty();
		if (data!=null) {
			$.each(data, function(i, item) {
				var row = "<TR>";
				$.each(item, function(j, field) {
					if (j=="NPI") {
						row += "<TD><input type=\"checkbox\" id=\"" + field + "\"></TD>";
					}else {
						row +='<TD>'+field+'</TD>'; 
					}
				});
				row+='</TR>';
				$('#resultsTable tbody').append(row);
			});
		} else {
			showMessage('No matching providers were found.');
		}
	});

	$('#ProvidersSearch').hide();
	$('#ProvidersShortList').hide();
	$('#ProvidersList').show();
}

function showShortProviderList(){

	$('#MessageArea').hide();

	var selectedNPIs = new Array();
	$('#resultsTable input:checked').each(function() {
	    	selectedNPIs.push($(this).attr('id'));
    	});

	if (selectedNPIs.length==0) {
		showMessage('No providers were selected.');
		return;
	}
	var requeststring = API_URL_PREFIX+"shortlist";

	var len= selectedNPIs.length;
	if (len >3) {
		showMessage('Too many providers were selected, maximum is three.');
		return;
	}

	for(var i=0; i < len; i++) {

		requeststring+="&NPI";
		requeststring+=i+1;
		requeststring+="=";
		requeststring+=selectedNPIs[i];
	}

	$.getJSON(requeststring,function(data){
		if (data!=null) {
			$('#shortresultsTable tbody').empty();
			$.each(data, function(i, item) {
				var row = "<TR>";
				if (i=="transaction"){
					row +='<TD>'+'<strong>'+"Transaction number: "+'</strong>'+item+'</TD>'; 
				}else{
					$.each(item, function(j, field) {
						row +='<TD>'+field+'</TD>'; 
					});
				}
				row+='</TR>';
				$('#shortresultsTable tbody').append(row);
			});
		} else {
			showMessage('No matching providers were found.');
		}
	});

	$('#ProvidersSearch').hide();
	$('#ProvidersList').hide();
	$('#ProvidersShortList').show();
}

function loadTaxonomyCodes() {
	var taxonomyTags = new Array();
	$.getJSON(API_URL_PREFIX+"taxonomy",function(data){
		$.each(data, function(i, code){
			taxonomyTags.push(code.Classification);
		});
	});
	$("#specialty").autocomplete({source: taxonomyTags});
}

function showMessage(text) {
	$('#messageText').text(text);
	$('#MessageArea').show();
}

function newSearch() {
	$('#ProvidersList').hide();
	$('#ProvidersShortList').hide();
	$('#MessageArea').hide();
	$('#ProvidersSearch').show();
}

function shortProviderList() {
	showShortProviderList();
}

function searchProviders() {
	showSearchResults();
}

$(document).ready(function() {
	loadTaxonomyCodes(); 	
});

