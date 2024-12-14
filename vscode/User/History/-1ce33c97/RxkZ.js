import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <A/>
    </div>
  );
}

function A() {
  return <div>A<B/></div>;
}
function B() {
  return <div>B<A/></div>;
}

export default App;hola
