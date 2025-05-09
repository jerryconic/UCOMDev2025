using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.IO;
public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlString ReadFile(SqlString filename)
    {
        // 將程式碼放在此處
        StreamReader rd = new StreamReader(filename.ToString());
        string s = rd.ReadToEnd();
        rd.Close();
        return new SqlString (s);
    }
}
