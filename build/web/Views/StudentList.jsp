<%-- 
    Document   : StudentList
    Created on : Apr 8, 2023, 4:40:38 PM
    Author     : HP
--%>
<%@ page import="Models.Data" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Calendar " %>

<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script
    src="https://code.jquery.com/jquery-3.6.4.js"
    integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
crossorigin="anonymous"></script>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CourseManagement</title>
        <style>
            tr:hover{
                background: #ececec;
                cursor: pointer;
            }
        </style>
    </head>
    <body class="m-2">
        <h1 class="py-3 px-1">Course Management</h1>
        <ul class="nav nav-tabs m-1">
            <li class="nav-item">
                <a class="nav-link" aria-current="page" href="/CourseManagementWeb/Course">Courses</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="#">Students</a>
            </li>
        </ul>
        <div class="my-4">
            <div class="d-flex justify-content-between mb-1">
                <div>
                    <div class="input-group">
                        <button class="btn btn-outline-dark" id="SortBtn" type="button">Sort</button>
                        <select class="form-select" id="SortType" style="width: 100px">
                            <option value="Asc" selected>Asc</option>
                            <option value="Desc">Desc</option>
                        </select>
                        <select class="form-select" id="SortData" style="width: 150px">
                            <option selected>Choose...</option>
                            <option value="Name">Name</option>
                            <option value="Grade">Grade</option>
                        </select>
                    </div>
                </div>
                <div>
                    <button type="button" class="btn btn-outline-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#AddStudentModal">Add 🐼</button>
                    <button type="button" class="btn btn-outline-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#EditStudentModal">Edit 🐇</button>
                    <button type="button" class="btn btn-outline-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#DeleteStudentModal">Delete 🐸</button>
                </div>

                <div class="input-group" style="width: 300px">
                    <input id="search_text" name="search_name" type="text" class="form-control" placeholder="Student's name" aria-label="Recipient's username" aria-describedby="button-addon2">
                    <button class="btn btn-outline-dark" type="submit" id="search_btn">Search</button>
                </div>
            </div>
            <table id ="table" class="table">
                <thead class="table-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Grade</th>
                        <th scope="col">Birthday</th>
                        <th scope="col">Address</th>
                        <th scope="col">Notes</th>
                    </tr>
                </thead>
                <tbody id="table_body">
                    <%
                        var data = Data.getInstance().StudentList;
                        int i = 1;
                        for(String id : data.keySet()){ 
                        var info = data.get(id);%>
                    <tr ondblclick="rowDBClick(this)">

                        <th scope="row"><%=i%></th>

                        <td><%=id%></td>
                        <td><%=info[0] %></td>
                        <td><%=info[1] %></td>
                        <td><%=info[2] %></td>
                        <td><%=info[3] %></td>
                        <td><%=info[4] %></td>
                    </tr>
                    <% i=i+1;
                    }%>
                </tbody>
            </table>
        </div>
        <div class="modal fade" id="AddStudentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >ADD NEW STUDENT</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/CourseManagementWeb/Student?action=add" method="post">
                            <label for="id" class="form-label">ID</label>
                            <input type="text" name="id" class="form-control" id="id" placeholder="20120435" required>
                            <label for="name" class="form-label mt-3">Name</label>
                            <input type="text" name="name" class="form-control" id="name" placeholder="Lê Thị Ngọc Bích" required>
                            <label for="grade" class="form-label mt-3">Grade</label>
                            <input type="text" name="grade" class="form-control" id="grade" placeholder="5.5" required>
                            <label for="dob" class="form-label mt-3">BirthDay</label>
                            <input type="text" name="dob" class="form-control" id="dob" placeholder="yyyy-mm-dd" required>
                            <label for="address" class="form-label mt-3">Address</label>
                            <input type="text" name="address" class="form-control" id="address" placeholder="" required>
                            <label for="notes" class="form-label mt-3">Notes</label>
                            <input type="text" name="notes" class="form-control" id="notes" placeholder="">
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" 
                                        data-bs-dismiss="modal" style="width: 80px">Cancel</button>
                                <button type="submit" class="btn btn-primary"
                                        style="width: 80px">Add</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>
        <div class="modal fade" id="DeleteStudentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >REMOVE STUDENT</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/CourseManagementWeb/Student?action=delete" method="post">
                            <label for="id" class="form-label">ID</label>
                            <input type="text" name="id" class="form-control" id="id" placeholder="20120435" required>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" 
                                        data-bs-dismiss="modal" style="width: 80px">Cancel</button>
                                <button type="submit" class="btn btn-danger"
                                        style="width: 80px">Delete</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>
        <div class="modal fade" id="EditStudentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >EDIT STUDENT INFO</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/CourseManagementWeb/Student?action=edit" method="post">
                            <label for="id" class="form-label">ID</label>
                            <select class="form-select" name="id" id="id_select_edit">
                                <option selected>Select ID</option>
                                <%  
                                    for(String id : data.keySet()){%>
                                <option value=<%=id%>><%=id%></option>
                                <%}%>
                            </select>
                            <label for="name_edit" class="form-label mt-3">Name</label>
                            <input type="text" name="name" class="form-control" id="name_text_edit" placeholder="Lê Thị Ngọc Bích" required>
                            <label for="grade" class="form-label mt-3">Grade</label>
                            <input type="text" name="grade" class="form-control" id="grade_text_edit" placeholder="5.5" required>
                            <label for="dob" class="form-label mt-3">BirthDay</label>
                            <input type="text" name="dob" class="form-control" id="dob_text_edit" placeholder="yyyy-mm-dd" required>
                            <label for="address" class="form-label mt-3">Address</label>
                            <input type="text" name="address" class="form-control" id="address_text_edit" placeholder="" required>
                            <label for="notes" class="form-label mt-3">Notes</label>
                            <input type="text" name="notes" class="form-control" id="notes_text_edit" placeholder="">

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" 
                                        data-bs-dismiss="modal" style="width: 80px">Cancel</button>
                                <button type="submit" class="btn btn-warning"
                                        style="width: 80px">Update</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>
        <div class="modal fade" id="StudentGradeModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >GRADE</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/CourseManagementWeb/Course?action=edit" method="post">
                            <label for="year" class="form-label mb-1">Year</label>
                            <select class="form-select mb-1" id="year" name="year" style="width: 100px">
                                <%  var calendar = Calendar.getInstance();
                                    var currentYear = calendar.get(Calendar.YEAR);
                                    for(var y=2010;y<currentYear+5;y++){
                                    if(y==currentYear){%>
                                <option value=<%=y%> selected><%=y%></option>
                                <%continue;}%>
                                <option value=<%=y%>><%=y%></option>
                                <%}%>
                            </select>
                            <table id="grade-table" class="table table-bordered my-3">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">ID</th>
                                        <th scope="col">Course's Name</th>
                                        <th scope="col">Grade</th>
                                    </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </form>

                    </div>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
        <script type="text/javascript">

            $("#id_select_edit").change(function () {
                var id = $(this).val();
                console.log(id);
                $.ajax({
                    type: 'GET',
                    url: '/CourseManagementWeb/StudentData',
                    data: {
                        action: 'edit',
                        id: id
                    },
                    success: function (data) {
                        const info = data.split(",");
                        $('#name_text_edit').val(info[0]);
                        $('#grade_text_edit').val(info[1]);
                        $('#dob_text_edit').val(info[2]);
                        $('#address_text_edit').val(info[3]);
                        $('#notes_text_edit').val(info[4]);
                    }
                });
            });

            $("#search_btn").click(function () {
                var name = $("#search_text").val();
                console.log(name);
                $.ajax({
                    type: 'GET',
                    url: '/CourseManagementWeb/StudentData',
                    data: {
                        action: "search",
                        name: name
                    },
                    success: function (data) {
                        var table = $("tbody");
                        table.find("tr").remove();
                        const list = data.split("~");
                        console.log(list[0]);
                        for (var i = 0; i < list.length - 1; i++) {

                            const info = list[i].split(",");
                            console.log(info[0]);
                            table.append(`
                                <tr>
                                    <th scope="row">`+(i+1)+`</th>
                                    <td>` + info[0] + `</td>
                                    <td>` + info[1] + `</td>
                                    <td>` + info[2] + `</td>
                                    <td>` + info[3] + `</td>
                                    <td>` + info[4] + `</td>
                                    <td>` + info[5] + `</td>
                                </tr>
                            `);
                        }
                    }
                });
            });

            $("#SortBtn").click(function () {
                const type = $("#SortType").val();
                const name_data = $("#SortData").val();
                
                const rows = $("#table_body tr").get();
                console.log(type, name_data, rows);
                var col;
                if (name_data === "Name") {
                    col = 1;
                } else if (name_data === "Grade") {
                    col = 2;
                    // Sắp xếp các hàng dựa trên giá trị của cột đầu tiên
                } else {
                    return;
                }

                rows.sort(function (a, b) {
                    // Lấy giá trị của cột đầu tiên của hai hàng a và b
                    var aValue = $(a).children('td').eq(col).text();
                    var bValue = $(b).children('td').eq(col).text();
                    console.log(name_data, type);
                    if (name_data === "Name") {
                        var a, b;
                        var arr = aValue.split(" ");
                        a = arr[arr.length - 1];
                        arr = bValue.split(" ");
                        b = arr[arr.length - 1];
                        console.log(a, b);
                        if (type === "Asc") {
                            return a.localeCompare(b);
                        } else if (type === "Desc") {
                            return b.localeCompare(a);
                        }
                    }

                    // So sánh giá trị của hai hàng a và b
                    aValue = parseFloat(aValue);
                    bValue = parseFloat(bValue);
                    if (type === "Asc") {
                        if (aValue < bValue) {
                            return -1;
                        } else if (aValue > bValue) {
                            return 1;
                        } else {
                            return 0;
                        }

                    } else if (type === "Desc") {
                        if (aValue < bValue) {
                            return 1;
                        } else if (aValue > bValue) {
                            return -1;
                        } else {
                            return 0;
                        }
                    }
                });

                $("tbody").empty();

                $.each(rows, function (index, row) {
                    $('table').append(row);
                });
            });
            
            $("#year").change(function (){
                
            });
            
            function loadGradeTable(student_id){
                var year = $("#year").val();
                $.ajax({
                    type: 'GET',
                    url: '/CourseManagementWeb/SICData',
                    data:{
                        action: "load_student_grade_table",
                        student_id: student_id,
                        year: year
                    },
                    success: function (data) {
                        var table = $("#grade-table tbody");
                        console.log(table);
                        table.find("tr").remove();
                        const list = data.split("~");
                        console.log(list[0]);
                        for (var i = 0; i < list.length - 1; i++) {
                            const info = list[i].split(",");
                            console.log(info[0]);
                            table.append(`
                                 <tr>
                                     <th scope="row">` + (i + 1) + `</th>
                                     <td>` + info[0] + `</td>
                                     <td>` + info[1] + `</td>
                                     <td>` + info[2] + `</td>
                                 </tr>
                            `);
                        }
                    }
                });
            }
            
            function rowDBClick(obj) {
                // Lấy giá trị của các cột trong hàng đó
                var student_id = $(obj).find('td:eq(0)').text();
                var name = $(obj).find('td:eq(1)').text();
                console.log(student_id, name);
                // Hiển thị giá trị trong modal
                $('#StudentGradeModal').on('show.bs.modal', function (event) {
                    var text = student_id + " - " + name ;
                    $('#StudentGradeModal .modal-dialog .modal-content .modal-header h1').text(text);
                    
                    $("#year").attr("onchange",`loadGradeTable("`+student_id+`")`);
                    loadGradeTable(student_id);
                    
                });
                // Mở modal
                $('#StudentGradeModal').modal('show');
            }

        </script>

    </body>

</html>

