const page = {
    init: () =>{
        $("#btn-save").on('click', () =>{
            page.save();
        });

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
    }
}
page.init();
