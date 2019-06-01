$(function () {

    $('#add_btn').click(function () {
        methods.addHandle()
    })

    $('#show_tbody').on('click','.edit', function () {
        //console.log(2);
        trIndex = $('.edit', '#show_tbody').index($(this));
        addEnter = false;
        $(this).parents('tr').addClass('has_case');
        methods.editHandle(trIndex);
    })

    $('#search_btn').click(function () {
        methods.seachName();
    })

    $('#back_btn').click(function () {
        $('#Ktext').val(' ');
        methods.resectList();
    })

    $('.del').click(function () {
    		//console.log($(this).parents('tr').attr('tea_id'));
        //console.log($(this).parents('tr').attr('tea_name'));
        //if(confirm("")) {
         //   var tea_id = $(this).parents('tr').attr('tea_id');
         //   $(this).parents('tr').remove();
        //}
        var tea_name = $(this).parents('tr').attr('tea_name');
        if(confirm('确定要删除教师 ' + tea_name + ' 的相关信息吗？')) {
            $(this).parents('tr').remove();
            var tea_id = $(this).parents('tr').attr('tea_id');
            //console.log(tea_id);
            $.ajax({
                type:"Post",
                url:"Service/AdminDel",
                data:{
                    "tea_id": tea_id
                },
                dataType: "json",
                success:function(data) {
                }
            });
            bootbox.alert({
                title: "提示",
                message: "删除成功！",
                closeButton:false
            });
        }
    })

    $('#renyuan').on('hide.bs.modal',function() {
        addEnter = true;
        $('#show_tbody tr').removeClass('has_case');
        $('#xztb input').val(' ');
        $('#xztb select').find('option:first').prop('selected', true)
    });

})

var addEnter = true,
    noRepeat = true,
    jobArr = [],
    phoneArr = [],
    tdStr = '',
    trIndex,
    hasNullMes = false,
    tarInp = $('#xztb input'),
    tarSel = $('#xztb select');

var methods = {

    addHandle: function (the_index) {
        hasNullMes = false;
        methods.checkMustMes();
        if (hasNullMes) {
            return;
        }
        if (addEnter) {
        		methods.setStr();
            $('#show_tbody').append('<tr>' + tdStr + '</tr>');
            $('#renyuan').modal('hide');
            
            var re = new RegExp("<td>(.*?)</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td>.*?", "i");
            var r = tdStr.match(re);
            //console.log(r);
            for (var i = 1; i < 8; i++) {
                console.log(typeof(r[i]));
            }
            
            $.ajax({
                type:"Post",
                url:"Service/AdminAdd",
                data:{
                		"d1name": r[2],
                    "teacher_name": r[3],
                    "teacher_title": r[4],
                    "teacher_tel": r[5],
                    "teacher_address": r[6],
                    "teacher_email": r[7]
                },
                dataType: "json",
                success:function(data) {
                }
            });
            
            bootbox.alert({
                title: "提示",
                message: "添加成功！",
                closeButton:false
            });
        		/*
            methods.checkRepeat();
            if (noRepeat) {
                methods.setStr();
                $('#show_tbody').append('<tr>' + tdStr + '</tr>');
                $('#renyuan').modal('hide');
            }
            */
        }else{
        		//console.log(11);
            methods.setStr();
            $('#show_tbody tr').eq(trIndex).empty().append(tdStr);

            var tea_id = $('#show_tbody tr').eq(trIndex).attr('tea_id');
            //console.log(tea_id);
            var re = new RegExp("<td>(.*?)</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td>.*?", "i");
            var r = tdStr.match(re);
            //console.log(r);
            //for (var i = 1; i < 8; i++) {
            //    console.log(r[i]);
            //}

            $('#renyuan').modal('hide');

            $.ajax({
                type:"post",
                url:"Service/AdminUpdate",
                data:{
                    "tea_id": tea_id,
                    "d1name": r[2],
                    "teacher_name": r[3],
                    "teacher_title": r[4],
                    "teacher_tel": r[5],
                    "teacher_address": r[6],
                    "teacher_email": r[7]
                },
                success:function(data) {
                }
            });
            bootbox.alert({
                title: "提示",
                message: "修改成功！",
                closeButton:false
            });
        }
    },
    editHandle: function (the_index) {
        var tar = $('#show_tbody tr').eq(the_index);
        var nowConArr = [];
        //console.log(tar.find('td').length);
        for (var i=0; i<tar.find('td').length-1;i++) {
            var a = tar.children('td').eq(i).html();
            //console.log(a);
            nowConArr.push(a);
        }

        
        $('#renyuan').modal('show');
        
        console.log(nowConArr[0]);
        $("#select_2").empty();
		$.ajax({
	        type: "Post",
	        url: "Service/son_dept",
	        data: {"father_dept": nowConArr[0]},
	        dataType: "json",
	        success: function (data) {
	            //$("#select_1").html("<option value=''>请选择省份</option>");
	            		//console.log(data[0].length);
	                	var len = 0;
	                	for(key in data[0]) {
	                		len++;
	                	}
	                	for(var i=0;i<len;i++) {
	                		$("#select_2").append("<option>" + data[0][i] + "</option>");
	                	}
	        }
	    });

        for (var j=0;j<tarInp.length;j++) {
            tarInp.eq(j).val(nowConArr[j+2]);
        }
        
        tarSel.eq(1).val(nowConArr[1]);
        tarSel.eq(0).val(nowConArr[0]);

    },
    setStr: function () {

        tdStr = '';
        //tdStr+= '<td>' + tarSel.eq(0).val() + '</td>'
        for (var b=0; b<tarSel.length; b++) {
            tdStr+= '<td>' + tarSel.eq(b).val() + '</td>'
        }
        for (var a=0; a<tarInp.length; a++) {
            tdStr+= '<td>' + tarInp.eq(a).val() + '</td>'
        }
        
        tdStr+= '<td><a href="#" class="edit">编辑</a> <a href="#" class="del">删除</a></td>';

    },
    seachName: function () {

        var a = $('#show_tbody tr');
        var nameVal = $('#Ktext').val().trim();
        var nameStr = '',
            nameArr = [];

        if (nameVal==='') {
            bootbox.alert({
                title: "提示",
                message: "搜索内容不能为空",
                closeButton:false
            })
            return;
        }

        for (var c=0;c<a.length;c++) {
            var txt = $('td:eq(2)', a.eq(c)).html().trim();
            nameArr.push(txt);
        }

        a.hide();
        for (var i=0;i<nameArr.length;i++) {
            if (nameArr[i].indexOf(nameVal)>-1) {
                a.eq(i).show();
            }
        }
    },
    resectList: function () {
        $('#show_tbody tr').show();
    },
    checkMustMes: function () {

        if ($('.teacherName').val().trim()==='') {
            bootbox.alert({
                title: "提示",
                message: "姓名为必选项，请填写",
                closeButton:false
            })
            hasNullMes = true;
            return
        }
        if ($('.teacherTitle').val().trim()==='') {
            bootbox.alert({
                title: "提示",
                message: "职称为必选项，请填写",
                closeButton:false
            })
            hasNullMes = true;
            return
        }
        if ($('.phoneNum').val().trim()==='') {
            bootbox.alert({
                title: "提示",
                message: "办公电话号码为必选项，请填写",
                closeButton:false
            })
            hasNullMes = true;
            return
        }

    },
    checkRepeat: function () {

        jobArr = [], phoneArr = [];

        for (var i = 0; i<$('#show_tbody tr:not(".has_case")').length;i++) {
            var par = '#show_tbody tr:not(".has_case"):eq(' + i + ')';
            var a = $('td:eq(1)', par).html().trim(),
                b = $('td:eq(2)', par).html().trim();
            jobArr.push(a);
            phoneArr.push(b);
        }
        var jobNum = $('.jobNum').val().trim(),
            phoneNum = $('.phoneNum').val().trim();

        if (jobArr.indexOf(jobNum)>-1) {
            noRepeat = false;
            bootbox.alert({
                title: "提示",
                message: "工号重复了，请重新输入",
                closeButton:false
            })
            return;
        }
        if (phoneArr.indexOf(phoneNum)>-1) {
            noRepeat = false;
            bootbox.alert({
                title: "提示",
                message: "手机号码重复了，请重新输入",
                closeButton:false
            })
            return;
        }
        noRepeat = true;
    }
}
