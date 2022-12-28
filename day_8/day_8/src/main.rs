#[derive(Debug)]
struct Map {
    width: usize,
    height: usize,
    map: Vec<u8>,
}

impl Map {
    fn new(width: u8, height: u8) -> Self {
        let mut map = Map {
            width: width.into(),
            height: height.into(),
            map: vec![0; (width * height) as usize],
        };
        for i in 0..width {
            map.set(i.into(), 0, 1);
            map.set(i.into(), <u8 as Into<usize>>::into(height) - 1, 1);
        }
        for i in 0..height {
            map.set(0, i.into(), 1);
            map.set(<u8 as Into<usize>>::into(width) - 1, i.into(), 1);
        }
        map
    }

    fn set(&mut self, x: usize, y: usize, value: u8) {
        let coord = self.width * y + x;
        self.map[coord] = value;
    }
}

fn main() {
    let map = Map::new(5, 5);
    dbg!(map);
    println!("Hello, world!");
}
