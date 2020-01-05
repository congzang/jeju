import json
import pymysql

def getConnection():
    return pymysql.connect(host = '172.30.1.29',
                            user = 'root',
                            port = 3306,
                            password = 'acorn1234Q!',
                            db = 'homework1',
                            charset = 'utf8',
                            use_unicode = True,
                            autocommit = True)

def getStudentList():
    conn = getConnection()
    cur = conn.cursor()
    cur.callproc("select_student")

    if(cur.rowcount):
        result = cur.fetchall()

    else:
        result = 0

    cur.close()
    conn.close()

    return result

def setStudent(data):
    conn = getConnection()
    cur = conn.cursor()

    args = (data['name'], data['class'], data['birth'], data['gender'], data['kor'], data['eng'], data['mat'], 0)
    cur.callproc("insert_student", args)
    result = cur.execute('SELECT @_insert_student_7')

    cur.close()
    conn.close()

    return json.dumps({'result': result})

def putStudent(data):
    conn = getConnection()
    cur = conn.cursor()

    args = (data['id'], data['name'], data['class'], data['birth'], data['gender'], data['kor'], data['eng'], data['mat'], 0)
    cur.callproc("update_student", args)
    result = cur.execute('SELECT @_update_student_8')
    print(result)
    cur.close()
    conn.close()

    return json.dumps({'result': result})


def delStudent(sid):
    conn = getConnection()
    cur = conn.cursor()

    args = (sid, 0)
    cur.callproc("delete_student", args)
    result = cur.execute('SELECT @_delete_student_1')

    cur.close()
    conn.close()

    return json.dumps({'result': result})


