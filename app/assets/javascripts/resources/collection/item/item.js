// console.log('item file executed!');
//$(document).on('turbolinks:load', function() {
$(document).ready(function () {
    // console.log('event triggered!');

    $('form[id="collection/field_search"], form[id="collection/item_search"]').on('change', function() {
        page_reload();
    });

    function page_reload() {
        let field_form = $('form[id="collection/field_search"]');
        let item_form = $('form[id="collection/item_search"]');
        let href = decodeURI(window.location.href);
        let item_id = /collection\/items\/(\d+)/.exec(href)[1];
        let q_s = '', f_s = '', page_q = '', page_f = '';

        if (href.includes('q[s]')) {
            q_s = '&' + /(?:(?=.*&)q\[s\]=(.+?)&|(?!.*&)q\[s\]=(.+))/.exec(href)[0];
        }
        if (href.includes('f[s]')) {
            f_s = '&' + /(?:(?=.*&)f\[s\]=(.+?)&|(?!.*&)f\[s\]=(.+))/.exec(href)[0];
        }
        if (href.includes('page_q=')) {
            page_q = '&' + /page_q=\d+/.exec(href)[0];
        }
        if (href.includes('page_f=')) {
            page_f = '&' + /page_f=\d+/.exec(href)[0];
        }

        let sort_params = q_s + f_s;
        let pagy_params = page_q + page_f;
        let url = `/collection/items/${item_id}?${field_form.serialize()}&${item_form.serialize()}${sort_params}${pagy_params}`;

        window.location.href = url;
    }
});
//});
