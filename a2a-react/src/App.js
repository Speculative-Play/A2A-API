import './App.css';
import axios from "axios";
import Users from "./components/users";
import { useEffect, useState} from "react";

const API_URL = "http://localhost:3000/api/v1/users";

function getAPIData() {
  return axios.get(API_URL).then((response) => response.data)
}

function App() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    let mounted = true;
    getAPIData().then((items) => {
      if (mounted) {
        setUsers(items);
      }
    });
    return () => (mounted = false);    
  }, []);

  return (
    <div className="App">
      {/* <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header> */}
      <h1>Hello A2A!</h1>
      {/* <Users users={users} /> */}
    </div>
  );
}

export default App;
