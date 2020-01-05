from flask import Flask, request, render_template, redirect
from dao import student

app = Flask(__name__)


@app.route('/')
def hello_world():
    return render_template("index.html")

@app.route("/studentAct", methods=["GET","POST","DELETE"])
def studentAct():
    # 조회
    if request.method == 'GET':
        return student.getstudent()

    # 저장(신규등록, 수정)
    elif request.method == 'POST':
        sid = request.form['sid']
        sname = request.form['sname']
        sClass = request.form['class']
        birth = request.form['birth']
        gender = request.form['gender']
        kor  = request.form['kor']
        eng  = request.form['eng']
        mat  = request.form['mat']
        print(sid)

        # 학번이 없으면 신규입력
        if( sid == "" ):
            data = {'name': sname, 'class': sClass, 'birth': birth, 'gender': gender, 'kor': kor, 'mat': mat, 'eng': eng}
            return student.setStudent(data)
            
        # 학번이 있으면 수정
        else:
            data = {'id': sid, 'name': sname, 'class': sClass, 'birth': birth, 'gender': gender, 'kor': kor, 'mat': mat, 'eng': eng}
            return student.putStudent(data)

    # 삭제
    elif request.method == 'DELETE':
        name = request.form['sid']
        return  student.delStudent(name)

@app.route("/student")
def studentList():
    result = student.getStudentList()
    return render_template("student.html", object_list = result)

if __name__ == '__main__':
    app.run()

