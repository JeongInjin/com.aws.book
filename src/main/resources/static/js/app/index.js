const page = {
    init: () =>{
        $("#btn-save").on('click', () =>{
            page.save();
        });

        $('#btn-update').on('click', () =>{
            page.update();
        });

        $('#btn-delete').on('click', () =>{
            page.delete();
        });
    },
    getId: () =>{
        return $("#id").val();
    },
    validation: (data) => {
        let result = true;
        const dataValues = Object.values(data);

        dataValues.forEach((v) =>{
            if(!v) result = false;
        });
        return result;
    },
    save: () =>{
        const data = {
            title: $("#title").val(),
            author: $("#author").val(),
            content: $("#content").val()
        };

        if(!page.validation(data)){
            console.log("모든 값은 필수입니다.");
            return false;
        }

        $.ajax({
           type: 'POST',
           url: '/api/v1/posts',
           dataType: 'json',
           contentType: 'application/json; charset=utf-8',
           data: JSON.stringify(data)
        }).done(() =>{
            alert("글이 등록되었습니다");
            window.location.href = '/';
        }).fail((e) =>{
            alert(JSON.stringify(e));
        });
    },
    update: () =>{
      const data ={
          title: $("#title").val(),
          content: $("#content").val()
      };

        $.ajax({
            type: 'PUT',
            url: '/api/v1/posts/' + page.getId(),
            dataType: 'json',
            contentType:'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function() {
            alert('글이 수정되었습니다.');
            window.location.href = '/';
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    },
    delete: () =>{
        $.ajax({
            type: 'DELETE',
            url: '/api/v1/posts/' + page.getId(),
            dataType: 'json',
            contentType:'application/json; charset=utf-8',
        }).done(function() {
            alert('글이 삭제되었습니다.');
            window.location.href = '/';
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    },
}
page.init();
