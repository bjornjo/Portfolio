import React from 'react'
import Album from './Album.js'

export default class AlbumList extends React.Component {
    constructor(props) {
        super(props);

        this.sortBy = this.sortBy.bind(this);

        this.filterAlbum = this.filterAlbum.bind(this);

        this.state = {
            sortBy: 'year',
            filterAlbum: ''
        };
    }

    sortBy(tag) {
        this.setState({
            sortBy: tag
        });
    }

    filterAlbum(input) {
        this.setState({
            filterAlbum: input.toLowerCase()
        });
    }

    byInput(album, filter) {
        return album.year.includes(filter)
            || album.artist.toLowerCase().includes(filter)
            || album.title.toLowerCase().includes(filter)
    }

    render() {
        return (
            <div>
                <input placeholder="Search" type="text" onChange={(event) => this.filterAlbum(event.target.value)}/>

                <table>
                    <thead>
                    <tr>
                        <th onClick={() => this.sortBy('title')}>TITLE</th>
                        <th onClick={() => this.sortBy('artist')}>ARTIST</th>
                        <th onClick={() => this.sortBy('year')}>YEAR</th>
                    </tr>
                    </thead>
                    <tbody>
                    {this.props.albums
                        .filter(album => this.byInput(album, this.state.filterAlbum))
                        .sort((left, right) => left[this.state.sortBy].localeCompare(right[this.state.sortBy]))
                        .map((album, index) => <Album key={index} {...album}/>)}
                    </tbody>
                </table>
            </div>
        )
    }
}