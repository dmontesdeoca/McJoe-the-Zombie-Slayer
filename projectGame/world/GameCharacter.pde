
class GameCharacter extends GameObject {
  String[][] mapArr;
  Map map;
  GameCharacter( int c0, Map map ) {
    super( c0 );
    mapArr = new String[map.getMaxX()][map.getMaxY()];
    arrayCopy( map.getMapArray(), mapArr );
    this.map = map;
  }
  
  void kick( int direction ) {
    switch( direction ) {
      case NORTH:
        if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y - grid_size ) / grid_size ) ).equals( "0" ) ) {
          super.kick( direction );
        }
        break;
      case SOUTH:
        if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y + grid_size ) / grid_size ) ).equals( "0" ) ) {
          super.kick( direction );
        }
        break;
      case WEST:
        if ( map.getValue( ( int )( ( pos.x - grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "0" ) ) {
          super.kick( direction );
        }
        break;
      case EAST:
        if ( map.getValue( ( int )( ( pos.x + grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "0" ) ) {
          super.kick( direction );
        }
        break;
    } // switch
}