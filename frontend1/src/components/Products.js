import React from 'react';
import ShowProducts from './showproducts/showproducts';

class Products extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      error: null,
      isLoaded: false,
      products: []
    };
  }

  componentDidMount() {
    fetch('http://localhost:4200/products')
      .then(res => res.json())
      .then(
        (result) => {
            console.log(result)
          this.setState({
            isLoaded: true,
            products: result
          });
        },
        // error handler
        (error) => {
          this.setState({
            isLoaded: true,
            error
          });
        }
      )
  }

  render() {

    const { error, isLoaded, products } = this.state;

    if (error) {
      return (
        <div className="col">
          Error: {error.message}
        </div>
      );
    } else if (!isLoaded) {
      return (
        <div className="col">
          Loading...
        </div>
      );
    } else {
      return (
        <div className="col">
          <p> {products.map((prod,index) => 
            <ShowProducts key={index} name={prod.name} price={prod.price}/>
          )}</p>
        </div>
      );
    }
  }
}

export default Products;










/*
import React,{PureComponent} from 'react';
//import Auxi from '../auxiliary/auxi';
import Axios from 'axios';
import Showproducts from './showproducts/showproducts';
//var p =[{name:"ada"},{name:"audbiad"}];

var p = [];

export default class extends PureComponent{
    
    constructor(props){
        super(props);
        this.state = {
            data:'b'
        }
    }
    
    
    

    productsFetch = () =>{
        Axios.get("http://localhost:4200/products").then(res=>{
            
            console.log(res.data);
            p = res.data;
            this.setState({data:'a'});
    }
        )};
/*
    shouldComponentUpdate(nextProps, nextState) {
        console.log("khbdhakd")
        return this.state.data !== nextState.data;
      }
      */
     /*
      render(){
          this.productsFetch();
          return(
            <div>
                djkabwdbakj
                {p}
            </div>
          );
      }




}





/*
var p = [];

export default class Products extends React.Component{

    state = {
        data:''
    };

    productsFetch = (e) =>{
        Axios.get("http://localhost:4200/products").then(res=>{
            
            p = res.data;
            console.log(p);
            this.setState({data:res.data});
            

        });
    }
    componentWillUpdate(){
        
        console.log("dadba");
    }
    shouldComponentUpdate(nextProps,nextState){
        return this.state !== nextState;
    }

    render(){
       // var products = [...this.productsFetch()];
       this.productsFetch();
       console.log(p);
        return (
            <div>
               
              
            </div>
        );
    };

}



//export default Products;


/*
var p = [];

const abc = () => {Axios.get("http://localhost:4200/products").then(res=>{
    console.log(res.data);
    p = res.data;

    return(res.data);
});
}


const products = (props) => p.map((p1,index)=>{
    abc();
    return(
        
        <Showproducts key={index} name={p1.name}/>    
        
    )
});

*/
