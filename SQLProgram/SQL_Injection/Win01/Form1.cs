using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Win01
{
    public partial class Form1 : Form
    {
        //string connstr = "Server=.;Database=TSQL;uid=john;pwd=1234;";
        string connstr = @"Server=.\SQL2;Database=Northwind;Trusted_Connection=true;";
        public Form1()
        {
            InitializeComponent();
        }

        private void btnExecuteSQL_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection(connstr);
            SqlCommand cmd = cn.CreateCommand();
            cmd.CommandText = @"SELECT * FROM dbo.Employees 
                            WHERE FirstName='" + txtName.Text + "'";
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            dr.Close();
            cn.Close();
            grvData.DataSource = dt;


        }

        private void btnNamedParam_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection(connstr);
            SqlCommand cmd = cn.CreateCommand();
            cmd.CommandText = @"SELECT * FROM dbo.Employees WHERE FirstName=@FirstName";
            cmd.Parameters.AddWithValue("@FirstName", txtName.Text);
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            dr.Close();
            cn.Close();
            grvData.DataSource = dt;

        }
    }
}
