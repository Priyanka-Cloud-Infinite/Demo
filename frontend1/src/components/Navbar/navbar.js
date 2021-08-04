import React from 'react';
import {Navbar,Nav,Form,FormControl,Button} from 'react-bootstrap';
import { NavLink } from "react-router-dom";
import './navbar.css';

  const nav = (props) => {
    return (
        <Navbar bg="dark" variant="dark">
          <NavLink to="/"><Navbar.Brand >Navbar</Navbar.Brand></NavLink>
          <Nav className="mr-auto">
          
            
              <NavLink className="Nav_link" to="/products">Products</NavLink>{' '}

          </Nav>
          <Form inline>
            <FormControl type="text" placeholder="Search" className="mr-sm-2" />
            <Button variant="outline-info">Search</Button>
          </Form>
        </Navbar>
        

    );
  }

  export default nav;
