use std::fs::File;
use std::io::{self, BufRead};

fn sizes(input: io::Lines<io::BufReader<File>>) -> Vec<u64> {
    let mut current_path = [0_usize; 64];
    let mut path_head = 0_usize;
    let mut folder_counter = 0_usize;
    let mut sizes: Vec<u64> = Vec::with_capacity(200);

    for _i in 0..200 {
        sizes.push(0);
    }

    for line in input.flatten() {
        let mut parts = line.split(" ");
        match parts.next() {
            Some("$") => match parts.next() {
                Some("ls") => (),
                Some("cd") => match parts.next() {
                    Some("..") => {
                        path_head -= 1;
                    }
                    Some(_) => {
                        current_path[path_head] = folder_counter;
                        folder_counter += 1;
                        path_head += 1;
                    }
                    None => unreachable!(),
                },
                _ => unreachable!(),
            },
            Some("dir") => (),
            Some(file_size) => {
                let file_size = file_size.parse::<u64>().unwrap();
                for i in 0..path_head {
                    sizes[current_path[i]] += file_size;
                }
            }
            _ => unreachable!(),
        }
    }

    sizes
}

fn part_1(sizes: &Vec<u64>) -> u64 {
    sizes.iter().filter(|s| **s <= 100_000).sum()
}

fn part_2(sizes: &mut Vec<u64>) -> u64 {
    let total_space = 70_000_000;
    let target_space = 30_000_000;
    let free_space = total_space - sizes[0];
    let target = target_space - free_space;
    let mut target_sizes = sizes
        .iter()
        .filter(|x| **x >= target)
        .collect::<Vec<&u64>>();
    target_sizes.sort();
    *target_sizes[0]
}

fn main() {
    match File::open("../input.txt") {
        Ok(file) => {
            let input = io::BufReader::new(file).lines();
            let mut sizes = sizes(input);

            dbg!(part_1(&sizes));
            dbg!(part_2(&mut sizes));
        }
        Err(e) => println!("{}", e),
    }
}
