$(document).ready(function(){

    getAppointments();

$("#newAppointment").hide();
$("#searchButton").click(function(){
		var searchString = $("#search").val();
		console.log(searchString);
		getAppointments(searchString);		
});
$("#addButton").click(function(){
		getForm();
		var appointment;
		// appointment.date = $("#newDate").val();
		// appointment.time = $("#newTime").val();
		// appointment.description = $("#newDescription").val();
		// makeAjaxPost(appointment);
});

$("#cancelButton").click(function(){
	$("#newAppointment").hide();
	$("#new").show();
});


function getForm(){
	$("#new").hide();
	$("#newAppointment").show();
}

function getAppointments(searchString){

			$.ajax({            
            url: "getAppointments.pl",
            data: { 
                "search": searchString
            },
            type: "GET",
            success: function(responseJson) {               

                           // var responseJson = JSON.parse(responseJson);
                //   var result = "";
                //   $.each(responseJson, function(i,data) {
                //     // we can parse using datetime library but for now space is ok for splitting
                //     var datetime = responseJson[i].appdatetime.split(' ');
                //     result += "<tr><td>" + datetime[0] + "</td>" + "<td>" + datetime[1] + "</td>" + "<td>" + responseJson[i].description + "</td></tr>";
                //   });
                //   $("#tblData tbody").html(result);
                mydata =JSON.parse(responseJson);
                $("#resultSpace").text("");
                    var $table = $("<table class='table'>").appendTo($("#resultSpace")); // Create HTML <table> element and append it to HTML DOM element with ID "resultSpace".
                        $table.append($("<thead>"));                        
                        $table.append($("<th>").text("Date")); 
                        $table.append($("<th>").text("Time"));
                        $table.append($("<th>").text("Description"));
                        $table.append($("</thead>"));
                    $.each(mydata, function(index, appointment) {    // Iterate over the JSON array.
                            var datetime = appointment.appdatetime.split(' ');
                            $table.append($("<tbody>"));  
                            $("<tr class ='active'>").appendTo($table)                     // Create HTML <tr> element, set its text content with currently iterated item and append it to the <table>.
                            .append($("<td>").text(datetime[0]))              // Create HTML <td> element, set its text content with name of currently iterated product and append it to the <tr>.
                            .append($("<td>").text(datetime[1]))           // Create HTML <td> element, set its text content with price of currently iterated product and append it to the <tr>.
                            .append($("<td>").text(appointment.description));
                            $table.append($("</tbody>"));                    
                    });
                
            }
           

		
	});
}
	
});