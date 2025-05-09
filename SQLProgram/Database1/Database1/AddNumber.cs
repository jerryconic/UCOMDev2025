using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlInt32 AddNumber(SqlInt32 a, SqlInt32 b)
    {
        int n1 = (int)a;
        int n2 = (int)b;
        return new SqlInt32(n1 + n2);
    }
}
