

layui.use('form', function () {
    var form = layui.form;

    //监听提交
    form.on('submit(demo1)', function (data) {
        var t = $('#t').val()
        var s = $('#s').val()
        var q = $('#q').val()

        var ss = "saddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"
        // layer.msg(JSON.stringify(data.field));
        layer.msg("success: " + t + " s: " + s + " q:" + q)


        $.ajax({
            url: "/DeleteCardMachine",
            method: "GET",
            // dataType: "json",
            data: {
                t: t,
                q: q,
                s: s,
                ss: ss,
            },

            success: function (data) {

            },
            error: function () {
                console.log("error");
            },

        });
        return false;
    });
});


function s(){
    
}