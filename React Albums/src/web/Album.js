import React from 'react'



export default class Album extends React.Component {
    render() {
        return <tr>
            <td>{this.props.title}</td>
            <td>{this.props.artist}</td>
            <td>{this.props.year}</td>
        </tr>
    }
}
