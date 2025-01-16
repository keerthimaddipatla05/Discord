from common import *
us='''
* US2

   As a:  Server Owner
 I want:  To grant or revoke specific permissions for members
So That:  I can quickly manage user capabilities
'''

def update_permissions(role_id, permissions):
    tmpl = '''
    UPDATE UserRole
    SET permissions = %s
    WHERE roleID = %s;
    SELECT * FROM UserRole WHERE roleID = %s;
    '''
    cmd = cur.mogrify(tmpl, (permissions, role_id, role_id))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    pp(rows)
    show_table(rows, 'roleID roleName color permissions serverID')

update_permissions(1, 'Read/Write')
