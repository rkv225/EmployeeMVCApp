using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeeApp.Models
{
    public class CreateEmployeeViewModel
    {
        [Required]
        public string EmployeeName { get; set; }

        [Required]
        [DataType(DataType.Date)]
        public DateTime EmployeeDOB { get; set; }

        [Required]
        public EmployeeGender Gender { get; set; }

        [Required]
        public string Address { get; set; }

        [Required]
        public int StateId { get; set; }
        public EmployeeState State { get; set; }

        [BindProperty]
        public List<int> EmployeeHobbies { get; set; }
    }
}
