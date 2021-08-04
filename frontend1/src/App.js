import './App.css';
import {BrowserRouter as Router,Switch,Route} from 'react-router-dom';

import Nav from './components/Navbar/navbar';
import ProductComponent from './components/Products';


function App() {
  return (
    <Router>
      <div>
        <Nav />
        <ProductComponent />
      </div>
        
      <Switch>
        <Route exact path='/products' Component={ProductComponent} />


      </Switch>
    </Router>
  );
}
export default App;
