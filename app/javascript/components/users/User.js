import React from "react"
import PropTypes from "prop-types"
import user from '../../assets/user.scss'
class User extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      name: this.props.user.name,
      email: this.props.user.email,
      ediable: false
    }
  }

  handleEdit(){
    this.setState({ediable: !this.state.ediable})

  }

  renderUserShow(){
    return(
      <React.Fragment>
        <h3>マイページ</h3>
        <p>{`名前: ${this.state.name}`}</p>
        <p>{`メールアドレス: ${this.state.email}`}</p>
        <button onClick={()=> this.handleEdit()}>編集する</button>
      </React.Fragment>
    )
  }

  handleSubmit(e){
    e.preventDefault()
    
    const formDate = new FormData();
    formDate.append("user[name]", e.target.name.value)
    formDate.append("user[email]", e.target.email.value)

    fetch(`/admin/users/${this.props.user.id}`,{
      method: "PUT",
      mode: 'cors',
      credentials: 'include',
      body: formDate
    }).then((response) => console.log(response))
    
    this.setState({["name"]: e.target.name.value,["email"]: e.target.email.value})

  }

  renderEditUser(){
    return(
      <React.Fragment>
        <form onSubmit={(e)=> this.handleSubmit(e)}>
          <input type="text" name="name" defaultValue={this.state.name}/><br/>
          <input type="text" name="email" defaultValue={this.state.email}/><br/>
          <input type="submit" value="保存"/>
        </form>
        <button onClick={()=> this.handleEdit()}>X</button>
      </React.Fragment>
    )
  }

  renderUser(ediable){
    if (ediable) {
      return(this.renderEditUser())
    } else {
      return(this.renderUserShow())
    }
  }

  render () {
    const {ediable} = this.state
    debugger
    return (
      <React.Fragment>
        <div className="container">
        {this.renderUser(ediable)}
        </div>
      </React.Fragment>
    );
  }
}


export default User
