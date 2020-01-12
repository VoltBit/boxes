import psycopg2
import os


class PostgresClient(object):
    table_list_q = """SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'"""
    table_header_q = """SELECT column_name FROM information_schema.columns WHERE table_name = 'experiment_result';"""
    conn = None
    cursor = None

    def init(self):
        try:
            print(f"Using pass: {os.getenv('PSQL_BOX_PASS')}")
            self.conn = psycopg2.connect(dbname='datadb', user='postgres', host='localhost', port=9000,
                        password=os.getenv('PSQL_BOX_PASS'))
            self.cursor = self.conn.cursor()
        except(e):
            print("I am unable to connect to the database")

    def get_tables(self):
        if self.cursor:
            self.cursor.execute(self.table_list_q)
            for table in self.cursor.fetchall():
                print(table)
            self.cursor.execute(self.table_header_q)
            print(self.cursor.fetchall())
        else:
            print("Connection is not initialized")


def main():
    pc = PostgresClient()
    pc.init()
    pc.get_tables()

if __name__ == '__main__':
    main()
