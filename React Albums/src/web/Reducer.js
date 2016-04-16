export default (state = {
    user: undefined
}, action) => {

    switch(action.type) {
        case 'SET_USER':
            return Object.assign({
                user: action.data
            }, ...state);
        case 'LOGOUT':
            return state;
        default: return state;
    }
}
