$(document).ready(function(){
	
	var active = $('#tabs li[class="active"]');
	var firstLi = $('#tabs li').first();
	var firstContent = $('#tabs_content div').first();
		
	if(active.length == 0){
		firstLi.addClass('active');
		firstContent.fadeIn();
	}	
	
    //  When user clicks on tab, this code will be executed
    $("#tabs li").click(function() {
        //  First remove class "active" from currently active tab
        $("#tabs li").removeClass('active');
 
        //  Now add class "active" to the selected/clicked tab
        $(this).addClass("active");
 
        //  Hide all tab content
        $(".category").hide();
 
        //  Here we get the href value of the selected tab
        var selected_tab = $(this).find("a").attr("href");
 
        //  Show the selected tab content
        $(selected_tab).fadeIn();
 
        //  At the end, we add return false so that the click on the link is not executed
        return false;
    });
});

$(document).ready(function(){
	$('input[type="checkbox"][name="half"]').change(function() {
	    if(this.checked) {
	    	$('input[type="checkbox"][name="mini"]').attr('disabled','true');
	    	$('input[id*="spinner"]').attr('disabled','true');
	    }else{
	    	$('input[type="checkbox"][name="mini"]').removeAttr('disabled');
	    	$('input[id*="spinner"]').removeAttr('disabled');
	    }
	});	
});
