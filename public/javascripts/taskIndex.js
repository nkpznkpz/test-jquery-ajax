  var taskIndex={};
  var isEditable = false;
  $(document).ready(function(){
    taskIndex.show=function(isNew){
      $.ajax({
        url:"/task/index",
        type:"post",
        data:"authenticity_token="+_token,
        success:function(data){
          var tmp = "",star_class="";
          if(data.length!=0){
            for(var i=0;i<data.length;i++){
              tmp+='<div class="task-container" id="task-id'+data[i].task.id+'">';
              star_class = (data[i].task.star)?'star_2':'star_1';
              tmp+='<div class="'+star_class+'" onclick="taskIndex.update_star('+data[i].task.id+')"></div>';
              tmp+='<a id="taskData'+data[i].task.id+'" class="task-data" href="/task/'+data[i].task.name+'/'+data[i].task.id+'">'+data[i].task.name+'</a>';

              tmp+='<div class="task-edit">';
              tmp+='<a href="javascript:void(0);" onclick="taskIndex.edit_task('+data[i].task.id+')">[Edit]</a>';
              tmp+='<a href="javascript:void(0);" onclick="taskIndex.delete_task('+data[i].task.id+')">[Delete]</a>';
              tmp+='</div>';
              tmp+='<div class="task-date">'+data[i].task.cr_date+'</div>';

              tmp+='</div>';
              //task description
              if(data[i].task.description){
                tmp+='<div id="taskDescription'+data[i].task.id+'" class="task-description">';
                tmp+='description : <br>'+data[i].task.description;
                tmp+='</div>';
              }
            }
            $("#taskData").html(tmp);

          }else{
            $("#showEdit").hide();
            $("#taskData").html("<div align='center'> No Task.</div>");

          }

          if(isNew){
            $("#taskData div:first").effect("highlight",{},3000);
            $("#btnSubmit").show();
            $("#ajax_img").hide();
            $("#name").val('');
            $("#description").val('');
            $("#priority").val('');
          }
          isEditable?$(".task-edit").show():$(".task-edit").hide();

          //star
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

          $(".task-container").hover(function(){
            $(this).next(".task-description").show();
          }, function(){
            $(this).next(".task-description").hide();
          });
        }//end success fn
      });
    }//end fn show
    taskIndex.show(false);
    //==============show button edit===================

    $("#showEdit").button({label:'Show edit'}).toggle(
    function () {
      $(this).button({label:'Hide edit'});
      $(".task-edit").show();
      isEditable = true;
    },
    function () {
      $(this).button({label:'Show edit'});
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

    $("#createTask").submit(function(){
      $("#btnSubmit").hide();
      $("#ajax_img").show();
      var name = $("#name").val();
      var description = $("#description").val();
      var priority = $("#priority").val();
      $.ajax({
        url:"/task/create",
        type:"post",
        data:"name="+name+"&description="+description+"&priority="+priority+"&authenticity_token="+_token,
        success:function(data){
          taskIndex.show(true);
        }
      });
      return false;
    });
    taskIndex.edit_task = function(taskId){
      alert(taskId);
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
                    taskIndex.show(false);
                  });
                }else{

                }

              }
            });
          }
        }
      });
    }
  });