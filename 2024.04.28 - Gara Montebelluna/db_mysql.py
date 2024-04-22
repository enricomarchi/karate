import pymysql
import pandas as pd

hostname = 'localhost'
username = 'root'
password = '932197'
database_name = 'karate'

def connessione_mysql():
    return pymysql.connect(host=hostname, user=username, password=password, db=database_name)

def read_stored_proc(nome, args):
    conn = connessione_mysql()
    try:
        with conn.cursor() as cursor:
            cursor.callproc(nome, args=args)
            result = cursor.fetchall()
            columns = [col[0] for col in cursor.description]
            df = pd.DataFrame(result, columns=columns)
            return df
    finally:
        conn.close()  
        
def execute_stored_proc(nome, args):
    conn = connessione_mysql()
    try:
        with conn.cursor() as cursor:
            if args:
                cursor.callproc(nome, args=args)
            else:
                cursor.callproc(nome)
            conn.commit() 
    except Exception as e:
        print(f"Si è verificato un errore: {e}")
        conn.rollback()
    finally:
        conn.close()

def read_query(sql, args):
    conn = connessione_mysql()
    try:
        with conn.cursor() as cursor:
            cursor.execute(sql, args)
            result = cursor.fetchall()
            columns = [col[0] for col in cursor.description]
            df = pd.DataFrame(result, columns=columns)            
            return df
    finally:
        conn.close()    

def execute_query(sql, args):
    conn = connessione_mysql()
    if args:
        args = list(map(lambda x: x.replace("'", "\'") if isinstance(x, str) else x, args))
    try:
        with conn.cursor() as cursor:
            if args:
                cursor.execute(sql, args)
            else:
                cursor.execute(sql)
            conn.commit()
    except Exception as e:  
        print(f"Errore durante l'esecuzione della query: {e}")
        conn.rollback()  
    finally:
        conn.close()  
