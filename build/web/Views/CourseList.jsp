<%-- 
    Document   : index
    Created on : Apr 8, 2023, 1:39:13 PM
    Author     : HP
--%>
<%@ page import="Models.Data" %>
<%@ page import="Models.Model" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar " %>
<%@ page import="java.util.HashMap" %>

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
                <a class="nav-link active" aria-current="page" href="/CourseManagementWeb/Course">Courses</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/CourseManagementWeb/Student">Students</a>
            </li>
        </ul>
        <div class="my-4">
            <div class="input-group mb-1" style="width: 160px">
                <button class="btn btn-outline-dark" id="ViewBtn" type="button" onclick="loadTable()" style="width: 60px">View</button>
                <select class="form-select" id="View_Year">
                    <%  var calendar = Calendar.getInstance();
                        var currentYear = calendar.get(Calendar.YEAR);
                        for(var c=2010;c<currentYear+5;c++){
                            if(c==currentYear){%>
                    <option value=<%=c%> selected><%=c%></option>
                    <%continue;
                                    }%>
                    <option value=<%=c%>><%=c%></option>
                    <%}%>
                </select>
            </div>
            <div class="d-flex justify-content-between">
                <div>
                    <div class="input-group">
                        <button class="btn btn-outline-dark" id="SortBtn" type="button" style="width: 60px">Sort</button>
                        <select class="form-select" id="SortType" style="width: 100px">
                            <option value="Asc" selected>Asc</option>
                            <option value="Desc">Desc</option>
                        </select>
                        <select class="form-select" id="SortData" style="width: 150px">
                            <option selected>Choose...</option>
                            <option value="ID">ID</option>
                            <option value="Name">Name</option>
                        </select>
                    </div>
                </div>
                <div>
                    <button type="button" class="btn btn-outline-dark text-nowrap" data-bs-toggle="modal" 
                            data-bs-target="#AddCourseModal">Add 🏫</button>
                    <button type="button" class="btn btn-outline-dark text-nowrap" data-bs-toggle="modal" 
                            data-bs-target="#EditCourseModal">Edit 🎒</button>
                    <button type="button" class="btn btn-outline-dark text-nowrap" data-bs-toggle="modal" 
                            data-bs-target="#DeleteCourseModal">Delete 💻</button>
                </div>

                <div class="input-group" style="width: 300px">
                    <input id="search_text" name="search_name" type="text" class="form-control" placeholder="Course's name" aria-label="Recipient's username" aria-describedby="button-addon2">
                    <button class="btn btn-outline-dark" type="submit" id="search_btn">Search</button>
                </div>
            </div>
            <table id="table" class="table my-1">
                <thead class="table-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">ID</th>
                        <th scope="col">Course's Name</th>
                        <th scope="col">Lecture</th>
                        <th scope="col">Year</th>
                        <th scope="col">Notes</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
        <div class="modal fade" id="AddCourseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >ADD NEW COURSE</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/CourseManagementWeb/Course?action=add" method="post">
                            <label for="id" class="form-label">ID</label>
                            <input type="text" name="id" class="form-control" id="id" placeholder="CSC13102" required>
                            <label for="name" class="form-label mt-3">Name</label>
                            <input type="text" name="name" class="form-control" id="name" placeholder="Lập trình ứng dụng Java" required>
                            <label for="lecture" class="form-label mt-3">Lecture</label>
                            <input type="text" name="lecture" class="form-control" id="lecture" placeholder="Nguyễn Văn Khiết" required>
                            <label for="year" class="form-label mt-3">Year</label>
                            <select class="form-select" id="year" name="year" style="width: 100px">
                                <%  for(var y=2010;y<currentYear+5;y++){
                                        if(y==currentYear){%>
                                <option value=<%=y%> selected><%=y%></option>
                                <%continue;}%>
                                <option value=<%=y%>><%=y%></option>
                                <%}%>
                            </select>
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
        <div class="modal fade" id="DeleteCourseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >REMOVE COURSE</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/CourseManagementWeb/Course?action=delete" method="post">
                            <label for="id" class="form-label">ID</label>
                            <input type="text" name="id" class="form-control" id="id" placeholder="Course's ID" required>
                            <label for="year" class="form-label mt-3">Year</label>
                            <select class="form-select mb-3" id="year" name="year" style="width: 100px">
                                <%  for(var y=2010;y<currentYear+5;y++){
                                        if(y==currentYear){%>
                                <option value=<%=y%> selected><%=y%></option>
                                <%continue;}%>
                                <option value=<%=y%>><%=y%></option>
                                <%}%>
                            </select>
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
        <div class="modal fade" id="EditCourseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >EDIT COURSE INFO</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/CourseManagementWeb/Course?action=edit" method="post">
                            <label for="year" class="form-label mt-3">Year</label>
                            <select class="form-select mb-3" id="year_text_edit" name="year" style="width: 100px">
                                <%  for(var y=2010;y<currentYear+5;y++){
                                        if(y==currentYear){%>
                                <option value=<%=y%> selected><%=y%></option>
                                <%continue;}%>
                                <option value=<%=y%>><%=y%></option>
                                <%}%>
                            </select>
                            <label for="id" class="form-label">Course's ID</label>
                            <select class="form-select" name="id" id="id_select_edit">
                                <option selected>Select ID</option>
                                <%  var data = Data.getInstance().CourseList.get(currentYear);
                                    for(String id : data.keySet()){%>
                                <option value=<%=id%>><%=id%></option>
                                <%}%>
                            </select>
                            <label for="name" class="form-label mt-3">Name</label>
                            <input type="text" name="name" class="form-control" id="name_text_edit" placeholder="Lập trình ứng dụng Java" required>
                            <label for="lecture" class="form-label mt-3">Lecture</label>
                            <input type="text" name="lecture" class="form-control" id="lecture_text_edit" placeholder="Nguyễn Văn Khiết" required>
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
        <div class="modal fade" id="View_StudentInCourseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >STUDENT LIST</h1>         
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>                        
                    </div>
                    <div class="modal-body">
                        <ul id="nav_studentincourse" class="nav nav-tabs m-1">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="#" 
                                   onclick="studentlist_in_course_modal_nav(this)">Student List</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" 
                                   onclick="studentlist_in_course_modal_nav(this)">Add Student</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#"
                                   onclick="studentlist_in_course_modal_nav(this)">Remove Student</a>
                            </li>
                        </ul>
                        <div class="my-3 mx-2">
                            <table id="student-table" class="table table-bordered my-3">
                                <thead >
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">ID</th>
                                        <th scope="col">Student's Name</th>
                                        <th scope="col">Grade</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">1</th>
                                        <td>aa</td>
                                        <td>aa</td>
                                        <td>aa</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="Add_StudentInCourseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >STUDENT LIST</h1>
                        <h2 id="course_info" class="modal-title fs-5" ></h2>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <ul id="nav_studentincourse" class="nav nav-tabs m-1">
                            <li class="nav-item">
                                <a class="nav-link" aria-current="page" href="#" 
                                   onclick="studentlist_in_course_modal_nav(this)">Student List</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" href="#" 
                                   onclick="studentlist_in_course_modal_nav(this)">Add Student</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#"
                                   onclick="studentlist_in_course_modal_nav(this)">Remove Student</a>
                            </li>
                        </ul>
                        <div class="my-3 mx-2">
                            <label for="student_id" class="form-label">Student's ID</label>
                            <input type="text" name="student_id" class="form-control" id="student_id" placeholder="20120435" required>
                            <label for="grade" class="form-label mt-3">Grade</label>
                            <input type="text" name="grade" class="form-control" id="grade" placeholder="5.5" required>
                            <div class="d-flex justify-content-center">
                                <button type="button" class="btn btn-primary mt-3" onclick="addStudent_btn_click()" style="width: 80px">Add</button>
                            </div> 
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="Remove_StudentInCourseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" >STUDENT LIST</h1>
                        <h2 id="course_info" class="modal-title fs-5" ></h2>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <ul id="nav_studentincourse" class="nav nav-tabs m-1">
                            <li class="nav-item">
                                <a class="nav-link" aria-current="page" href="#" 
                                   onclick="studentlist_in_course_modal_nav(this)">Student List</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" 
                                   onclick="studentlist_in_course_modal_nav(this)">Add Student</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" href="#"
                                   onclick="studentlist_in_course_modal_nav(this)">Remove Student</a>
                            </li>
                        </ul>
                        <div class="my-3 mx-2">
                            <form method="post" action="">
                                <label for="student_id" class="form-label">ID</label>
                                <input type="text" name="student_id" class="form-control" id="student_id" placeholder="20120435" required>
                                <div class="d-flex justify-content-center">
                                    <button type="button" class="btn btn-primary mt-3" style="width: 80px">Remove</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
        <script type = "text/javascript">
            window.onload = loadTable();
            function loadTable() {
                var year = $("#View_Year").val();
                $.ajax({
                    type: 'GET',
                    url: '/CourseManagementWeb/CourseData',
                    data: {
                        action: 'loadtable',
                        year: year
                    },
                    success: function (data) {
                        var table = $("#table tbody");
                        table.find("tr").remove();
                        const list = data.split("~");
                        console.log(list[0]);
                        for (var i = 0; i < list.length - 1; i++) {
                            const info = list[i].split(",");
                            console.log(info[0]);
                            table.append(`
                                 <tr ondblclick="rowDBClick(this)">
                                     <th scope="row">` + (i + 1) + `</th>
                                     <td>` + info[0] + `</td>
                                     <td>` + info[1] + `</td>
                                     <td>` + info[2] + `</td>
                                     <td>` + year + `</td>
                                     <td>` + info[3] + `</td>
                                 </tr>
                            `);
                        }
                    }
                });
            };
            

            $("#year_text_edit").change(function () {
                var year = $(this).val();
                console.log(year);
                $.ajax({
                    type: 'GET',
                    url: '/CourseManagementWeb/CourseData',
                    data: {
                        action: 'edit_getID',
                        year: year
                    },
                    success: function (data) {
                        console.log(data);
                        var id_list = $("#id_select_edit");
                        id_list.find("option").remove();
                        const info = data.split(",");
                        id_list.append(
                                `<option selected >Select ID</option>`);
                        for (var i = 0; i < info.length - 1; i++) {
                            id_list.append(
                                `<option value=` + info[i] + `>` + info[i] + `</option>`);
                        }

                    }
                });
            });
            
            $("#id_select_edit").change(function () {
                var id = $(this).val();
                var year = $("#year_text_edit").val();
                $.ajax({
                    type: 'GET',
                    url: '/CourseManagementWeb/CourseData',
                    data: {
                        action: 'edit_getInfo',
                        id: id,
                        year: year
                    },
                    success: function (data) {
                        const info = data.split(",");
                        $('#name_text_edit').val(info[0]);
                        $('#lecture_text_edit').val(info[1]);
                        $('#notes_text_edit').val(info[2]);
                    }
                });
            });
            
            $("#search_btn").click(function () {
                var name = $("#search_text").val();
                var year = $("#View_Year").val();
                $.ajax({
                    type: 'GET',
                    url: '/CourseManagementWeb/CourseData',
                    data: {
                        action: "search",
                        name: name,
                        year: year
                    },
                    success: function (data) {
                    var table = $("#table tbody");
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
                                        <td>` + year + `</td>
                                        <td>` + info[3] + `</td>
                                    </tr>`);
                    }
                                                   }
                });
            });
            
            $("#SortBtn").click(function () {
                const type = $("#SortType").val();
                const name_data = $("#SortData").val();
                const rows = $("#table tbody tr").get();
                console.log(type, name_data, rows);
                var col;
                if (name_data === "ID") {
                    col = 0;
                } else if (name_data === "Name") {
                    col = 1;
                } else {
                    return;
                }

                rows.sort(function (a, b) {
                    // Lấy giá trị của cột đầu tiên của hai hàng a và b
                    var aValue = $(a).children('td').eq(col).text();
                    var bValue = $(b).children('td').eq(col).text();
                    console.log(name_data, type);
                    if (type === "Asc") {
                        return aValue.localeCompare(bValue);
                    } else {
                        return bValue.localeCompare(aValue);
                    }
                });
                $("#table tbody").empty();
                $.each(rows, function (index, row) {
                    $('table').append(row);
                });
            });
            
            function rowDBClick(obj) {
                // Lấy giá trị của các cột trong hàng đó
                var course_id = $(obj).find('td:eq(0)').text();
                var course_name = $(obj).find('td:eq(1)').text();
                var year = $(obj).find('td:eq(3)').text();
                console.log(id, course_name);
                // Hiển thị giá trị trong modal
                $('#View_StudentInCourseModal').on('show.bs.modal', function (event) {
                    var header = course_id + " - " + course_name + " - " + year;
                    //View
                    $('#View_StudentInCourseModal .modal-dialog .modal-content .modal-header h1').text(header);
                    $.ajax({
                        type: 'GET',
                        url: '/CourseManagementWeb/SICData',
                        data:{
                            action: "load_student_table",
                            course_id: course_id,
                            year: year
                        },
                        success: function (data) {
                            var table = $("#student-table tbody");
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
                        },
                    });
                    //Add
                    $('#Add_StudentInCourseModal .modal-dialog .modal-content .modal-header h1').text(header);
                    var button = $('#Add_StudentInCourseModal .modal-dialog .modal-content .modal-body div div button');
                    button.attr("onclick",`addStudent_btn_click(this,"`+ course_id +`",`+year+`)`);
                    //Remove
                    $('#Remove_StudentInCourseModal .modal-dialog .modal-content .modal-header h1').text(header);
                    button = $('#Remove_StudentInCourseModal .modal-dialog .modal-content .modal-body div div button');
                    button.attr("onclick",`removeStudent_btn_click(this,"`+ course_id +`",`+year+`)`);
                });
                // Mở modal
                $('#View_StudentInCourseModal').modal('show');
            }

            function studentlist_in_course_modal_nav(obj) {
                $("#View_StudentInCourseModal").modal('hide');
                $("#Add_StudentInCourseModal").modal('hide');
                $("#Remove_StudentInCourseModal").modal('hide');
                var new_active = $(obj).text();
                console.log("new " + new_active);
                
                if (new_active === "Student List") {
                    $("#View_StudentInCourseModal").modal('show');
                } else if (new_active === "Add Student") {
                    $("#Add_StudentInCourseModal").modal('show');
                } else if (new_active === "Remove Student") {
                    $("#Remove_StudentInCourseModal").modal('show');
                }
            }
            
            function addStudent_btn_click(obj,course_id,year){
                var student_id=$("#student_id").val();
                var grade = $("#grade").val();

                $.ajax({
                    type: 'GET',
                    url: '/CourseManagementWeb/SICData',
                    data:{
                        action: "add_student",
                        course_id: course_id,
                        year: year,
                        student_id: student_id,
                        grade: grade
                    },
                    success: function (data) {
                        alert("Succefully ")
                    },
                    error: function () {
                        alert("Failed ")
                    }
                })
            }
            
            function removeStudent_btn_click(obj,course_id,year){
                var student_id=$(obj).parent().prev().val();

                $.ajax({
                    type: 'GET',
                    url: '/CourseManagementWeb/SICData',
                    data:{
                        action: "remove_student",
                        course_id: course_id,
                        year: year,
                        student_id: student_id
                    },
                    success: function (data) {
                        alert("Succefully ");
                    },
                    error: function () {
                        alert("Failed ");
                    }
                });
            }

        </script>

    </body>

</html>
