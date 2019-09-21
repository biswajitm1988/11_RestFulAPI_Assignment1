<%--
  Created by IntelliJ IDEA.
  User: ctrq181
  Date: 9/12/2019
  Time: 4:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Spring RestFulAPI Assignment 1</title>
    <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
            integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
            crossorigin="anonymous"></script>
    <style>
        table.mainTable {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            text-align: center;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        a.button {
            color: black;
            padding: 10px 20px;
            text-align: center;
            display: inline-block;
            text-decoration: none;
            font-size: 16px;
            margin-left: 20px;
        }
    </style>
</head>
<body>
<div align="center">
    <table class="mainTable">
        <tr>
            <th>
                Select Any Option
            </th>
        </tr>
        <tr>
            <td><a href="javascript:showDiv('addBook')" class="button">Add a Book</a></td>
        </tr>
        <tr>
            <td><a href="javascript:showDiv('updateBook')" class="button">Update a book</a></td>
        </tr>
        <tr>
            <td><a href="javascript:showDiv('delBook')" class="button">Delete a book</a></td>
        </tr>
        <tr>
            <td><a href="javascript:showDiv('searchBook')" class="button">Search for a book</a></td>
        </tr>
        <tr>
            <td><a href="javascript:getAllBooks()" class="button">Show All Books</a></td>
        </tr>
    </table>
    <br>

    <form name="bookForm" id="bookForm">
        <div id="addUpdateBookForm" style="display: none">
            <table>
                <tr>
                    <th id="updateTh" style="display:none;">Book Id</th>
                    <th>Book Title</th>
                    <th>Price</th>
                    <th>Volume</th>
                    <th>Published Date</th>
                </tr>
                <tr>
                    <td id="updateTr" style="display:none;">
                        <input type="text" name="title" id="bookId" width="20" placeholder="Enter Book Id">
                    </td>
                    <td>
                        <input type="text" name="title" id="title" width="20" placeholder="Enter Book Title">
                    </td>
                    <td>
                        <input type="text" name="price" id="price" width="20" placeholder="Enter Book Price">
                    </td>
                    <td>
                        <input type="text" name="volume" id="volume" width="20" placeholder="Enter Book Volume">
                    </td>
                    <td>
                        <input type="text" name="publishDate" id="publishDate" width="20" placeholder="mm/dd/yy">
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <div id="addBook" style="display: none">
        <button type="button" onclick="addBook()">Submit</button>
    </div>
    <div id="updateBook" style="display: none">
        <button type="button" onclick="updateBook()">Submit</button>
    </div>
    <div id="delBook" style="display: none">
        Enter the Book Id To Delete <input type="text" name="deleteBookId" id="deleteBookId" width="20">
        <button type="button" onclick="deleteBook()">Submit</button>
    </div>
    <div id="searchBook" style="display: none">
        Enter the Book ID To Search <input type="text" name="searchBookId" id="searchBookId" width="20">
        <button type="button" onclick="getBookById()">Submit</button>
    </div>
    <br>
    <div id="response" style="display: none">

    </div>

</div>
</body>
<script>
    const errMsg = "Please enter a valid input";

    function showDiv(divId) {
        $("#addBook").hide();
        $("#updateBook").hide();
        $("#delBook").hide();
        $("#searchBook").hide();
        $("#response").hide();
        $('#addUpdateBookForm').hide();
        $('#updateTh').hide();
        $('#updateTr').hide();
        if(divId==="addBook" || divId==="updateBook"){
            $('#addUpdateBookForm').show();
            if(divId==="updateBook"){
                $('#updateTh').show();
                $('#updateTr').show();
            }
        }
        $('#' + divId).show();
    }

    function getAllBooks() {
        $.ajax({
            type: "GET",
            url: "${pageContext.request.contextPath}/getAllBooks",
            success: function (response) {
                $("#response").html(buildHtmlTable(response));
                $("#response").show();
            },
            error: function (errorThrown) {
                $("#response").html(errorThrown);
                $("#response").show();
            }
        });
    }


    function getBookById() {
        const inputValue = $("#searchBookId").val();
        console.log("input >>" + inputValue + "<< input length >>" + inputValue.length);
        if (inputValue.length === 0) {
            alert(errMsg);
        } else {
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/getBookById/"+inputValue,
                success: function (response) {
                    $("#response").html(buildHtmlTable(response));
                    $("#response").show();
                },
                error: function (errorThrown) {
                    $("#response").html(errorThrown);
                    $("#response").show();
                }
            });
        }
    }

    function deleteBook() {
        const inputValue = $("#deleteBookId").val();
        console.log("input >>" + inputValue + "<< input length >>" + inputValue.length);
        if (inputValue.length === 0) {
            alert(errMsg);
        } else {
            $.ajax({
                type: "DELETE",
                url: "${pageContext.request.contextPath}/deleteBook/"+inputValue,
                data: {"deleteBookTitle": $("#deleteBookId").val()},
                success: function (response) {
                    $("#response").html(buildHtmlTable(response));
                    $("#response").show();
                },
                error: function (errorThrown) {
                    $("#response").html(errorThrown);
                    $("#response").show();
                }
            });
        }
    }

    function addBook() {
        const inputTitle = $("#title").val();
        const inputPrice = $("#price").val();
        const inputVolume = $("#volume").val();
        const inputPublishDate = $("#publishDate").val();
        if (inputTitle.length === 0
            || inputPrice.length === 0
            || inputVolume.length === 0
            || inputPublishDate.length === 0) {
            alert(errMsg);
        } else {
            let bookFormInputData = {
                title: inputTitle,
                price: inputPrice,
                volume: inputVolume,
                publishDate: inputPublishDate
            };
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/addBook",
                dataType : 'json',
                contentType:'application/json;charset=utf-8',
                data: JSON.stringify(bookFormInputData),
                success: function (response) {
                    $("#response").html(buildHtmlTable(response));
                    $("#response").show();
                },
                error: function (errorThrown) {
                    $("#response").html(errorThrown);
                    $("#response").show();
                }
            });
        }
    }

    function updateBook() {
        const inputBookId = $("#bookId").val();
        const inputTitle = $("#title").val();
        const inputPrice = $("#price").val();
        const inputVolume = $("#volume").val();
        const inputPublishDate = $("#publishDate").val();
        if (inputTitle.length === 0
            || inputPrice.length === 0
            || inputVolume.length === 0
            || inputPublishDate.length === 0) {
            alert(errMsg);
        } else {
            let bookFormInputData = {
                bookId: inputBookId,
                title: inputTitle,
                price: inputPrice,
                volume: inputVolume,
                publishDate: inputPublishDate
            };
            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/updateBook",
                dataType : 'json',
                contentType:'application/json;charset=utf-8',
                data: JSON.stringify(bookFormInputData),
                success: function (response) {
                    $("#response").html(buildHtmlTable(response));
                    $("#response").show();
                },
                error: function (errorThrown) {
                    $("#response").html(errorThrown);
                    $("#response").show();
                }
            });
        }
    }

    function buildHtmlTable(json) {
        let  table = $('<table/>');
        let  th = $('<tr/>');
        th.append("<th>Book ID</th>");
        th.append("<th>Book Title</th>");
        th.append("<th>Price</th>");
        th.append("<th>Volume</th>")
        th.append("<th>Published Date</th>")
        table.append(th);
        if(isArray(json)) {
            for (var i = 0; i < json.length; i++) {
                let tr = $('<tr/>');
                let book = json[i];
                tr.append("<td>" + book.bookId + "</td>");
                tr.append("<td>" + book.title + "</td>");
                tr.append("<td>" + book.price + "</td>");
                tr.append("<td>" + book.volume + "</td>");
                tr.append("<td>" + new Date(book.publishDate).toLocaleDateString("en-US") + "</td>");
                table.append(tr);
            }
        }else {
            let tr = $('<tr/>');
            let book = json;
            tr.append("<td>" + book.bookId + "</td>");
            tr.append("<td>" + book.title + "</td>");
            tr.append("<td>" + book.price + "</td>");
            tr.append("<td>" + book.volume + "</td>");
            tr.append("<td>" + new Date(book.publishDate).toLocaleDateString("en-US") + "</td>");
            table.append(tr);
        }
        return table;
    }
    function isArray(data) {
        return Object.prototype.toString.call(data) === '[object Array]';
    }
</script>
</html>