$(document).ready(function () {
    check_field_type();

    $('#collection_field_field_type').on('change', function() {
        check_field_type();
    });

    $('#collection_field_is_numeric').on('change', function() {
        check_is_numeric();
    });

    $('#collection_field_show_tooltip').on('change', function() {
        check_show_tooltip();
    });

    function check_field_type() {
        switch($('#collection_field_field_type').val()) {
            case 'text':
                $('#collection_field_field_values').closest('.form-field').hide();
                $('#collection_field_show_tooltip').closest('.form-field').show();
                check_show_tooltip()
                $('#collection_field_is_numeric').closest('.form-field').show();
                check_is_numeric();
                $('#collection_field_default_value').closest('.form-field').show();
                break;
            case 'textarea':
                $('#collection_field_field_values').closest('.form-field').hide();
                $('#collection_field_show_tooltip').closest('.form-field').show();
                check_show_tooltip()
                $('#collection_field_is_numeric').closest('.form-field').hide();
                check_is_numeric();
                $('#collection_field_default_value').closest('.form-field').show();
                break;
            case 'select':
                $('#collection_field_field_values').closest('.form-field').show();
                $('#collection_field_show_tooltip').closest('.form-field').show();
                check_show_tooltip()
                $('#collection_field_is_numeric').closest('.form-field').hide();
                check_is_numeric();
                $('#collection_field_default_value').closest('.form-field').show();
                break;
            case 'date':
                $('#collection_field_field_values').closest('.form-field').hide();
                $('#collection_field_show_tooltip').closest('.form-field').show();
                check_show_tooltip()
                $('#collection_field_is_numeric').closest('.form-field').hide();
                check_is_numeric();
                $('#collection_field_default_value').closest('.form-field').show();
                break;
            case 'checkbox':
                $('#collection_field_field_values').closest('.form-field').hide();
                $('#collection_field_show_tooltip').closest('.form-field').show();
                check_show_tooltip()
                $('#collection_field_is_numeric').closest('.form-field').hide();
                check_is_numeric();
                $('#collection_field_default_value').closest('.form-field').show();
                break;
            case 'radio':
                $('#collection_field_field_values').closest('.form-field').show();
                $('#collection_field_show_tooltip').closest('.form-field').show();
                check_show_tooltip()
                $('#collection_field_is_numeric').closest('.form-field').hide();
                check_is_numeric();
                $('#collection_field_default_value').closest('.form-field').show();
                break;
            case 'file':
                $('#collection_field_field_values').closest('.form-field').hide();
                $('#collection_field_show_tooltip').closest('.form-field').show();
                check_show_tooltip()
                $('#collection_field_is_numeric').closest('.form-field').hide();
                check_is_numeric();
                $('#collection_field_default_value').closest('.form-field').hide();
                break;
            default:
                $('#collection_field_field_values').closest('.form-field').hide();
                $('#collection_field_show_tooltip').closest('.form-field').hide();
                check_show_tooltip()
                $('#collection_field_is_numeric').closest('.form-field').hide();
                check_is_numeric();
                $('#collection_field_default_value').closest('.form-field').hide();
        }
    }

    function check_is_numeric() {
        if ($('#collection_field_is_numeric').is(':checked')) {
            $('#collection_field_no_format').closest('.form-field').show();
            $('#collection_field_precision').closest('.form-field').show();
            $('#collection_field_min_value').closest('.form-field').show();
            $('#collection_field_max_value').closest('.form-field').show();
            $('#collection_field_step').closest('.form-field').show();
        } else {
            $('#collection_field_no_format').closest('.form-field').hide();
            $('#collection_field_precision').closest('.form-field').hide();
            $('#collection_field_min_value').closest('.form-field').hide();
            $('#collection_field_max_value').closest('.form-field').hide();
            $('#collection_field_step').closest('.form-field').hide();
        }
    }

    function check_show_tooltip() {
        if ($('#collection_field_show_tooltip').is(':checked')) {
            $('#collection_field_tooltip').closest('.form-field').show();
        } else {
            $('#collection_field_tooltip').closest('.form-field').hide();
        }
    }
});
