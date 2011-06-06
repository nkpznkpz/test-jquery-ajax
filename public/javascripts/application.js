// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var taskIndex={};
$(document).ready(function(){
    $.ajaxSetup({
        'beforeSent':function(xhr){
            xhr.setRequestHeader("Accept","text/javascript")
            }
    });
	
	
    //star
    taskIndex.starClass=function(){
        $(".star_1").toggle(
            function () {
                $(this).addClass("star_2");
                $(this).removeClass("star_1");
            },
            function () {
                $(this).addClass("star_1");
                $(this).removeClass("star_2");
            });
        $(".star_2").toggle(
            function () {
                $(this).addClass("star_1");
                $(this).removeClass("star_2");
            },
            function () {
                $(this).addClass("star_2");
                $(this).removeClass("star_1");
            });
    };
    taskIndex.starClass();
    
    /*   $(".task-data").hover(function(){
      $(this).next(".task-description").show();
    }, function(){
      $(this).next(".task-description").hide();
    }); */
    //==============show button edit===================
    $("#showEdit").button({
        label:'Show edit'
    }).toggle(
        function () {
            $(this).button({
                label:'Hide edit'
            });
            $(".task-edit").show();
            isEditable = true;
        },
        function () {
            $(this).button({
                label:'Show edit'
            });
            $(".task-edit").hide();
            isEditable = false;
        });
    //==============end show button edit===================
    //update status star
    taskIndex.update_star = function(id){
        $.ajax({
            url:"/task/update_star",
            type:"post",
            data:"id="+id+"&authenticity_token="+_token
        });
    }

    $("#createForm").submit(function(){
        $("#createForm #btnSubmit").hide();
        $("#createForm .ajax_img").show();
        //request post(action , data[],success fn ,type)
        $.post($(this).attr('action')+'.js', $(this).serialize(),null, "script");
        return false;
    });
    taskIndex.updateTask=function(taskId){
        var $fm = $("#updateForm"+taskId);
        $("#updateForm"+taskId+" .btnSubmit").hide();
        $("#updateForm"+taskId+" .ajax_img").show();
        //alert($fm);
        $.post($fm.attr('action')+'.js', $fm.serialize(),null, "script");
        return false;
    }
    
    taskIndex.edit_task = function(taskId){
        //hide all edit panel
      
        //show edit panel
        $('#task-id'+taskId+" .task-edit").hide();
        //show ajax image
        $('#task-id'+taskId+" .task-date").before('<span class="ajax_img2" style="float:right"><%=image_tag "ajax-loader.gif"%></span>');
        //$('#task-id'+taskId+" .task-edit").hide();
        $.post("/task/show","id="+taskId+"&authenticity_token="+_token,null,"script");
    }
    taskIndex.hideEdit=function(taskId){
        $("#editForm"+taskId).slideUp('fast',function(){
            $(this).remove();
        });
        $("#task-id"+taskId).show();
        $("#task-id"+taskId+" .task-edit").show();
    }
    taskIndex.delete_task = function(taskId){
        $( ".confirm" ).dialog({
            modal:true,
            buttons: {
                "Cancel": function() {
                    $(this).dialog("close");
                },
                "Ok": function() {
                    $(this).dialog("close");
                    $.ajax({
                        url:"/task/delete",
                        type:"post",
                        data:"taskid="+taskId+"&authenticity_token="+_token,
                        success:function(result){
                            if(result=="true"){
                                $("#task-id"+taskId).fadeOut("slow",function(){
                                    $(this).remove();
                                });
                            }
                        }
                    });
                }
            }
        });
    }
});

  