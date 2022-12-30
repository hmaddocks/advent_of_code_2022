use std::fmt;
use std::fs::File;
use std::io::{self, BufRead};

#[derive(Debug)]
struct Map {
    width: usize,
    height: usize,
    map: Vec<u8>,
}

impl Map {
    fn new(width: usize, height: usize) -> Self {
        let mut map = Map {
            width,
            height,
            map: vec![0; (width * height) as usize],
        };
        for i in 0..width {
            map.set(i, 0, 1);
            map.set(i, height - 1, 1);
        }
        for i in 0..height {
            map.set(0, i, 1);
            map.set(width - 1, i, 1);
        }
        map
    }

    fn set(&mut self, x: usize, y: usize, value: u8) {
        let coord = self.width * y + x;
        self.map[coord] = value;
    }
}

impl fmt::Display for Map {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        for row in self.map.chunks(self.width) {
            for &cell in row {
                write!(f, "{:2} ", cell)?;
            }
            writeln!(f)?;
        }

        Ok(())
    }
}

fn part_1(input: &Vec<Vec<u8>>) -> u32 {
    let width = input[0].len();
    let height = input.len();

    let mut map = Map::new(width, height);
    // println!("{}", map);

    for y in 1..map.height - 1 {
        let mut highest = input[y][0];
        for x in 1..map.width - 1 {
            if input[y][x] > highest {
                highest = input[y][x];
                map.set(x, y, 1);
            }
        }
        let mut highest = input[y][map.width - 1];
        for x in (1..map.width - 1).rev() {
            if input[y][x] > highest {
                highest = input[y][x];
                map.set(x, y, 1);
            }
        }
    }

    for x in 1..map.width - 1 {
        let mut highest = input[0][x];
        for y in 1..map.height - 1 {
            if input[y][x] > highest {
                highest = input[y][x];
                map.set(x, y, 1);
            }
        }
        let mut highest = input[map.height - 1][x];
        for y in (1..map.height - 1).rev() {
            if input[y][x] > highest {
                highest = input[y][x];
                map.set(x, y, 1);
            }
        }
    }
    // println!("{}", map);
    map.map.iter().fold(0, |acc, tree| acc + *tree as u32)
}

fn score(input: &Vec<Vec<u8>>, tree_height: u8, x: usize, y: usize) -> u32 {
    let height = input.len();
    let width = input[0].len();
    if x == 0 || x == width - 1 || y == 0 || y == height - 1 {
        return 0;
    }
    // println!("{x} {y} {tree_height}");

    let mut right = 0;
    for h in x..(width - 1) {
        right += 1;
        if input[y][h + 1] >= tree_height {
            break;
        }
    }

    let mut left = 0;
    for h in (1..=x).rev() {
        left += 1;
        if input[y][h - 1] >= tree_height {
            break;
        }
    }

    let mut down = 0;
    for w in y..(height - 1) {
        down += 1;
        if input[w + 1][x] >= tree_height {
            break;
        }
    }

    let mut up = 0;
    for w in (1..=y).rev() {
        up += 1;
        if input[w - 1][x] >= tree_height {
            break;
        }
    }

    // if up != 0 && down != 0 && left != 0 && right != 0 {
    //     println!("{x} {y} {tree_height} {up} {down} {left} {right}");
    // }
    up * down * left * right
}

fn part_2(input: &Vec<Vec<u8>>) -> u32 {
    input
        .iter()
        .enumerate()
        .flat_map(|(y, row)| {
            row.iter()
                .enumerate()
                .map(|(x, tree)| score(input, *tree, x, y))
                .collect::<Vec<u32>>()
        })
        .max()
        .unwrap()
}

fn convert_line_to_digits(line: String) -> Vec<u8> {
    line.chars()
        .map(|c| c.to_digit(10).unwrap() as u8)
        .collect::<Vec<u8>>()
}

fn main() {
    match File::open("../input.txt") {
        Ok(file) => {
            let lines = io::BufReader::new(file).lines().flatten();
            // let lines = ["30373", "25512", "65332", "33549", "35390"];
            let input = lines.map(convert_line_to_digits).collect();
            dbg!(part_1(&input));
            dbg!(part_2(&input));
        }
        Err(e) => println!("{}", e),
    };
}
