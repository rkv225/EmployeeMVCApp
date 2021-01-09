using Microsoft.EntityFrameworkCore.Migrations;

namespace EmployeeApp.Migrations
{
    public partial class hobbyremve : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Hobby",
                table: "Employees");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Hobby",
                table: "Employees",
                type: "int",
                nullable: true);
        }
    }
}
