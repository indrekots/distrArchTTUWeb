// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function () {
	$('#add_customer, #add_contract, #update_contract, #update_customer, #add_address, #update_address, #add_commDevice, #update_commDevice').
	bind('ajax:success', function(xhr, data, status) {
		$('#notices').append("<div class='alert alert-success'><button type='button' class='close' data-dismiss='alert'>×</button><strong>" + data["head"] + "</strong> " + data["body"] + "</div>");
	})

	$('#add_customer, #add_contract, #update_contract, #update_customer, #add_address, #update_address, #add_commDevice, #update_commDevice').
	bind('ajax:error', function(xhr, data, status) {
		$('#notices').append("<div class='alert alert-error'><button type='button' class='close' data-dismiss='alert'>×</button><strong>Failure</strong> Oops, something went wrong</div>");
	})

	$('.delete_contract, .delete_customer, .delete_address, .delete_commDevice').
	bind('ajax:success', function(xhr, data, status) {
		$('#notices').append("<div class='alert alert-success'><button type='button' class='close' data-dismiss='alert'>×</button><strong>" + data["head"] + "</strong> " + data["body"] + "</div>");
		$('.table').find('tbody tr').each(function (index, value) {
			if ($(this).find('td').first().text() == data["id"]) {
				$(this).remove();
			}
		});
	})

	$('#search_form').bind('ajax:success', function(xhr, data, status) {
		$('#customers_table tbody').children().remove();
		$.each(data, function(index, value) {
			$('#customers_table tbody').append(getCustomersTableRow(value));
		});


		//$('#notices').append("<div class='alert alert-success'><button type='button' class='close' data-dismiss='alert'>×</button><strong>" + data["head"] + "</strong> " + data["body"] + "</div>");
	})


});

function getCustomersTableRow(data) {
	return $('<tr></tr>').append($('<td></td>').text(data.id))
				  .append($('<td></td>').text(data.firstName))
				  .append($('<td></td>').text(data.lastName))
				  .append($('<td></td>').append(getCustomerViewLink(data.id)))
				  .append($('<td></td>').append(getCustomerEditLink(data.id)));
}

function getCustomerViewLink(id) {
	 return $('<a></a>').attr('href', '/customers/' + id).text('View');
}

function getCustomerEditLink(id) {
	return $('<a></a>').attr('href', '/customers/' + id + '/edit').text('Edit');
}