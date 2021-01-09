using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using EmployeeApp;
using EmployeeApp.Models;
using Microsoft.Data.SqlClient;
using System.Configuration;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace EmployeeApp.Controllers
{
    public class EmployeesController : Controller
    {
        private readonly SqlConnection _conn;

        public EmployeesController(IConfiguration configuration)
        {
            _conn = new SqlConnection(configuration.GetConnectionString("EmployeeDbContext"));
        }

        // GET: Employees
        public async Task<IActionResult> Index()
        {
            SqlCommand comm = new SqlCommand("GetAllEmployees", _conn);
            comm.CommandType = System.Data.CommandType.StoredProcedure;
            SqlDataAdapter dataAdapter = new SqlDataAdapter(comm);
            DataTable dataTable = new DataTable();
            await _conn.OpenAsync();
            dataAdapter.Fill(dataTable);
            await _conn.CloseAsync();

            List<Employee> employees = new List<Employee>();
            foreach (DataRow row in dataTable.Rows)
            {
                employees.Add(new Employee()
                {
                    EmployeeId = Convert.ToInt32(row["EmployeeId"]),
                    EmployeeName = Convert.ToString(row["EmployeeName"]),
                    EmployeeDOB = Convert.ToDateTime(row["EmployeeDOB"]),
                    Gender = (EmployeeGender)Convert.ToInt32(row["Gender"]),
                    Address = Convert.ToString(row["Address"]),
                    StateId = Convert.ToInt32(row["StateId"]),
                    State = new EmployeeState() { Id = Convert.ToInt32(row["StateId"]), State = Convert.ToString(row["State"]) },
                });
            }
            return View(employees);
        }

        // GET: Employees/Details/5
        public async Task<IActionResult> Details(int id)
        {
            SqlCommand comm = new SqlCommand("GetEmployeeDetail", _conn);
            comm.CommandType = System.Data.CommandType.StoredProcedure;
            comm.Parameters.AddWithValue("@Id", id);
            SqlDataAdapter dataAdapter = new SqlDataAdapter(comm);
            DataTable dataTable = new DataTable();
            await _conn.OpenAsync();
            dataAdapter.Fill(dataTable);
            await _conn.CloseAsync();

            List<Employee> employees = new List<Employee>();
            foreach (DataRow row in dataTable.Rows)
            {
                employees.Add(new Employee()
                {
                    EmployeeId = Convert.ToInt32(row["EmployeeId"]),
                    EmployeeName = Convert.ToString(row["EmployeeName"]),
                    EmployeeDOB = Convert.ToDateTime(row["EmployeeDOB"]),
                    Gender = (EmployeeGender)Convert.ToInt32(row["Gender"]),
                    Address = Convert.ToString(row["Address"]),
                    StateId = Convert.ToInt32(row["StateId"]),
                    State = new EmployeeState() { Id = Convert.ToInt32(row["StateId"]), State = Convert.ToString(row["State"]) },
                });
            }
            if (employees.Count >= 1)
                return View(employees.FirstOrDefault());
            else
                return NotFound();
        }

        // GET: Employees/Create
        public IActionResult Create()
        {
            SqlCommand comm = new SqlCommand("GetAllStates", _conn);
            comm.CommandType = System.Data.CommandType.StoredProcedure;
            SqlDataAdapter dataAdapter = new SqlDataAdapter(comm);
            DataTable dataTable = new DataTable();
            _conn.Open();
            dataAdapter.Fill(dataTable);
            _conn.Close();

            List<EmployeeState> employeeStates = new List<EmployeeState>();
            foreach (DataRow row in dataTable.Rows)
            {
                employeeStates.Add(new EmployeeState()
                {
                    Id = Convert.ToInt32(row["Id"]),
                    State = Convert.ToString(row["State"])
                });
            }
            
            ViewData["StateId"] = new SelectList(employeeStates, "Id", "State");
            ViewData["Genders"] = new SelectList(GetGenders(), "Value", "Name");
            ViewData["Hobbies"] = new SelectList(GetHobbies(), "Value", "Name");
            return View();
        }

        // POST: Employees/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("EmployeeName,EmployeeDOB,Gender,Address,StateId,EmployeeHobbies")] CreateEmployeeViewModel employee)
        {
            string empHobbies = "";
            employee.EmployeeHobbies.ForEach(x => empHobbies += x.ToString() + ",");
            if (ModelState.IsValid)
            {
                SqlCommand comm = new SqlCommand("AddNewEmployee", _conn);
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("@Name", employee.EmployeeName);
                comm.Parameters.AddWithValue("@DOB", employee.EmployeeDOB);
                comm.Parameters.AddWithValue("@Gender", employee.Gender);
                comm.Parameters.AddWithValue("@Address", employee.Address);
                comm.Parameters.AddWithValue("@StateId", employee.StateId);
                comm.Parameters.AddWithValue("@Hobbies", empHobbies);
                await _conn.OpenAsync();
                int exec = await comm.ExecuteNonQueryAsync();
                await _conn.CloseAsync();
                if (exec >= 1)
                    return RedirectToAction(nameof(Index));
                else
                    return BadRequest();
            }
            return BadRequest();
        }

        private List<GenderObj> GetGenders()
        {
            List<GenderObj> genderObjs = new List<GenderObj>();
            foreach (var enu in Enum.GetValues(typeof(EmployeeGender)))
                genderObjs.Add(new GenderObj(enu.ToString(), (int)enu));
            return genderObjs;
        }

        private List<HobbyObj> GetHobbies()
        {
            List<HobbyObj> hobbyObjs = new List<HobbyObj>();
            foreach (var enu in Enum.GetValues(typeof(EmployeeHobby)))
                hobbyObjs.Add(new HobbyObj(enu.ToString(), (int)enu));
            return hobbyObjs;
        }
    }
}
