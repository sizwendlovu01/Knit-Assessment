import { useState } from "react";

const learners = [
  { id: 1, name: "Amahle Dlamini", grade: 8, amount: 3500, due: "2026-05-01", status: "Overdue" },
  { id: 2, name: "Lethabo Mokoena", grade: 10, amount: 4200, due: "2026-06-15", status: "Unpaid" },
  { id: 3, name: "Sipho Nkosi", grade: 9, amount: 3500, due: "2026-04-30", status: "Overdue" },
  { id: 4, name: "Zanele Khumalo", grade: 11, amount: 5100, due: "2026-06-01", status: "Paid" },
  { id: 5, name: "Tebogo Sithole", grade: 8, amount: 3500, due: "2026-06-20", status: "Unpaid" },
  { id: 6, name: "Naledi Motsepe", grade: 12, amount: 6000, due: "2026-05-15", status: "Overdue" },
  { id: 7, name: "Keanu Davids", grade: 9, amount: 3500, due: "2026-06-10", status: "Paid" },
  { id: 8, name: "Precious Mahlangu", grade: 11, amount: 5100, due: "2026-06-25", status: "Unpaid" },
];

function App() {
  const [search, setSearch] = useState("");

  const filteredLearners = learners.filter((learner) => {
    const term = search.toLowerCase();
    return learner.name.toLowerCase().includes(term) ||
      learner.grade.toString().includes(term);
  });

  const totalCollected = learners.filter(l => l.status === "Paid")
    .reduce((sum, l) => sum + l.amount, 0);

  const totalOutstanding = learners.filter(l => l.status !== "Paid")
    .reduce((sum, l) => sum + l.amount, 0);

  const overdueCount = learners.filter(l => l.status === "Overdue").length;

  const exportCSV = () => {
    const headers = ["Name","Grade","Amount Due","Due Date","Status"];
    const rows = filteredLearners.map(l => [l.name,l.grade,l.amount,l.due,l.status]);
    const csv = [headers.join(","), ...rows.map(r => r.join(","))].join("\n");

    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = "learners.csv";
    link.click();
    URL.revokeObjectURL(url);
  };

  const getStatusClass = (status) => {
    switch (status) {
      case "Paid": return "status paid";
      case "Unpaid": return "status unpaid";
      case "Overdue": return "status overdue";
      default: return "status";
    }
  };

  return (
    <div className="container">
      <h1>School Fee Dashboard</h1>

      <div className="summary-bar">
        <div className="card">
          <h3>Total Fees Collected</h3>
          <p>R{totalCollected.toLocaleString()}</p>
        </div>
        <div className="card">
          <h3>Total Fees Outstanding</h3>
          <p>R{totalOutstanding.toLocaleString()}</p>
        </div>
        <div className="card">
          <h3>Overdue Learners</h3>
          <p>{overdueCount}</p>
        </div>
      </div>

      <div className="controls">
        <input
          type="text"
          placeholder="Search by learner name or grade..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />
        <button onClick={exportCSV}>Export CSV</button>
      </div>

      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Grade</th>
            <th>Amount Due</th>
            <th>Due Date</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {filteredLearners.map((learner) => (
            <tr key={learner.id}>
              <td>{learner.name}</td>
              <td>{learner.grade}</td>
              <td>R{learner.amount.toLocaleString()}</td>
              <td>{learner.due}</td>
              <td><span className={getStatusClass(learner.status)}>{learner.status}</span></td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default App;
