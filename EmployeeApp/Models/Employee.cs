using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeeApp.Models
{
    public enum EmployeeGender
    {
        Male,
        Female
    }

    public enum EmployeeHobby
    {
        Sports,
        Music,
        Cooking,
        Reading,
        Writing,
        Photography
    }

    public class Employee
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int EmployeeId { get; set; }

        [Required]
        [MinLength(1)]
        public string EmployeeName { get; set; }
        
        [Required]
        [DataType(DataType.Date)]
        public DateTime EmployeeDOB { get; set; }
        
        [Required]
        public EmployeeGender Gender { get; set; }

        [Required]
        [MinLength(1)]
        public string Address { get; set; }
        
        [Required]
        [Display(Name = "State")]
        public int StateId { get; set; }
        public EmployeeState State { get; set; }
    }
}
